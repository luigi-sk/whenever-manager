require "Whenever"
require 'fileutils'
require 'tempfile'
require 'paperclip'
require 'state_machine'

module WheneverManager
  class Definition < ActiveRecord::Base
    attr_accessible :archived_at, :content, :crontab_content, :version, :schedule
    include Paperclip::Glue

    has_attached_file :schedule
    has_one :cron_migration, :class_name => 'WheneverManager::CronMigration'


    def self.schedule_read
      File.open("#{Rails.root}/config/schedule.rb").read.to_s
    end

    # states: [:new, :draft, :installed, :archived]
    # events: [:preview, :install, :backup]
    state_machine :initial => :new do
      event :preview do
        transition :new => :draft
      end

      event :install do
        transition :draft => :installed
      end

      event :backup do
        transition :installed => :backup
      end

      state :new do

      end

      state :draft do

      end
      before_transition :new => :draft do |definition, transition|
        definition.make_draft
      end

      state :installed do

      end
      before_transition :draft => :installed do |definition, transition|
        whenever_cmd = Crontab.new(
            :file => definition.schedule.path.to_s,
            :update => true,
            :identifier => identifier
        )

        # backup previous
        definition.build_cron_migration if definition.cron_migration.nil?
        definition.cron_migration.crontab_content = whenever_cmd.read_crontab
        definition.cron_migration.save

        # install new crontab
        begin
          whenever_cmd.run
        rescue => e
          Rails.logger.error("crontab file was not updated.\n====\n#{e.backtrace.join("\n")}")
        end
        definition.save
      end
      after_transition :draft => :installed do |definition, transition|
        definition.previous.backup
      end

      state :archived do

      end

      after_transition :installed => :archived do |definition, transition|
        definition.archived_at = DateTime.now
        definition.save
      end
    end

    # get previous entry
    # @return [WheneverManager::Definition]
    def previous
      @previous ||= Definition.where("created_at < ?", self.created_at).order("created DESC").first
    end

    # get previous entry
    # @return [WheneverManager::Definition]
    def next
      @previous ||= Definition.where("created_at > ?", self.created_at).order("created DESC").first
    end

    protected

    def make_draft
      file_name = Rails.root.join('tmp').join("schedule_tmp_#{DateTime.now.to_i}")
      f = File.open(file_name, 'w')
      f.write(self.content)
      f.close

      self.schedule = f.reopen(file_name,'r')
      self.crontab_content = Whenever::JobList.new(
          :file=>f.path.to_s).generate_cron_output
      save

      f.close
      File.delete(file_name)
    end

    # @return [String]
    def identifier
      Rails.application.class.parent_name
    end

  end
end

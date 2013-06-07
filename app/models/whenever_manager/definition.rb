module WheneverManager
  class Definition < ActiveRecord::Base
    attr_accessible :archived_at, :content, :crontab_content, :version, :schedule
    has_attached_file :schedule


    def self.schedule_read
      File.open("#{Rails.root}/config/schedule.rb").read.to_s
    end

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
        # TODO generate preview
      end

      state :installed do
        # TODO install new crontab & backup previous
      end

      state :archived do
        # TODO save actual crontab
      end
    end

  end
end

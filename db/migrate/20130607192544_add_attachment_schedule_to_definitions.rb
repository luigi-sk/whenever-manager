require 'paperclip/schema'
class AddAttachmentScheduleToDefinitions < ActiveRecord::Migration
  include Paperclip::Schema::Statements

  def self.up
    add_attachment :whenever_manager_definitions, :schedule
    #change_table :definitions do |t|
    #  t.attachment :schedule
    #end
  end

  def self.down
    drop_attached_file :whenever_manager_definitions, :schedule
  end
end

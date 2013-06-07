module WheneverManager
  class CronMigration < ActiveRecord::Base
    attr_accessible :crontab_content, :definition_id

    belongs_to :definition, :class_name => 'WheneverManager::Definition'
  end
end

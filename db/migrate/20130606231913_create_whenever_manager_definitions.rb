class CreateWheneverManagerDefinitions < ActiveRecord::Migration
  def change
    create_table :whenever_manager_definitions do |t|
      t.text :content
      t.text :crontab_content
      t.integer :version
      t.datetime :archived_at

      t.timestamps
    end
  end
end

class CreateWheneverManagerCronMigrations < ActiveRecord::Migration
  def change
    create_table :whenever_manager_cron_migrations do |t|
      t.integer :definition_id
      t.text :crontab_content

      t.timestamps
    end

    add_index(:whenever_manager_cron_migrations, :definition_id)
  end
end

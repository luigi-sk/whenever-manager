class AddStateToDefinition < ActiveRecord::Migration
  def change
    add_column :whenever_manager_definitions, :state, :string
  end
end

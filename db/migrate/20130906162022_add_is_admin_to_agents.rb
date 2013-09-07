class AddIsAdminToAgents < ActiveRecord::Migration
  def change
    add_column :agents, :isAdmin, :boolean, :default => false
  end
end

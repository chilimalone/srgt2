class ChangeAgentrefToReference < ActiveRecord::Migration
  def change
    rename_column :leases, :agent_references, :agent
  end
end

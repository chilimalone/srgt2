class ChangeAgentToReference < ActiveRecord::Migration
  def change
    change_table :leases do |t|
      t.remove :agent
      t.references :agent, index: true
    end
  end
end

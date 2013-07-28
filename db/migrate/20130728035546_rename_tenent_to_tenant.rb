class RenameTenentToTenant < ActiveRecord::Migration
  def change
    rename_table(:tenents, :tenants)
  end
end

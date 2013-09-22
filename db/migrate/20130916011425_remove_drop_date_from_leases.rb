class RemoveDropDateFromLeases < ActiveRecord::Migration
  def change
    remove_column :leases, :dropped_date
    add_column :tours, :dropped_date, :date
    remove_column :leases, :welcome_home
    add_column :tenants, :welcome_home, :boolean
    change_column :sales, :hear, :string, :default => ''
    change_column :rooms, :room_number, :string
  end
end

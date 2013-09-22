class PropertiesChanges < ActiveRecord::Migration
  def change
    change_column :leases, :move_out, :date
    change_table :leases do |t|
      t.remove :property_id
      t.references :room
    end
    change_table :sales do |t|
      t.references :room
      t.remove :property_id
    end
    change_table :tenants do |t|
      t.remove :property_id
    end
    change_table :tours do |t|
      t.remove :property_id
    end
    remove_column :properties, :individual_id
    change_table :rooms do |t|
      t.references :individual
    end
  end
end

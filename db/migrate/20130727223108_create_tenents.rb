class CreateTenents < ActiveRecord::Migration
  def change
    create_table :tenents do |t|
      t.references :individual, index: true
      t.date :leased_signed
      t.date :lease_expired
      t.references :property, index: true
      t.references :room, index: true

      t.timestamps
    end
  end
end

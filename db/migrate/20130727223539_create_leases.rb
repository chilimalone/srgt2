class CreateLeases < ActiveRecord::Migration
  def change
    create_table :leases do |t|
      t.references :client, index: true
      t.decimal :rental_amount
      t.string :move_out
      t.string :date
      t.date :move_in
      t.boolean :welcome_home
      t.boolean :thank_you_sent
      t.date :dropped_date
      t.text :comments
      t.string :agent_references
      t.decimal :referral_amount
      t.references :property, index: true

      t.timestamps
    end
  end
end

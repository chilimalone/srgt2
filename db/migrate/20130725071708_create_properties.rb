class CreateProperties < ActiveRecord::Migration
  def change
    create_table :properties do |t|
      t.string :street_1
      t.string :street_2
      t.string :city
      t.string :state
      t.string :zip
      t.text :notes
      t.references :individual, index: true

      t.timestamps
    end
  end
end

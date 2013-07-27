class CreateTours < ActiveRecord::Migration
  def change
    create_table :tours do |t|
      t.references :agent, index: true
      t.references :client, index: true
      t.date :date
      t.references :room, index: true
      t.text :comments
      t.references :property, index: true

      t.timestamps
    end
  end
end

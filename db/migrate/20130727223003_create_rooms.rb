class CreateRooms < ActiveRecord::Migration
  def change
    create_table :rooms do |t|
      t.references :property, index: true
      t.text :comments

      t.timestamps
    end
  end
end

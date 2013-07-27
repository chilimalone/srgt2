class CreateSales < ActiveRecord::Migration
  def change
    create_table :sales do |t|
      t.references :agent, index: true
      t.boolean :hear
      t.references :individual, index: true
      t.references :property, index: true
      t.date :closing_date
      t.string :company
      t.string :office_number

      t.timestamps
    end
  end
end

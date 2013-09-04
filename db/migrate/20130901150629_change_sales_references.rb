class ChangeSalesReferences < ActiveRecord::Migration
  def change
    change_table :sales do |t|
      t.remove :individual
      t.references :buyer
      t.references :broker
    end
  end
end

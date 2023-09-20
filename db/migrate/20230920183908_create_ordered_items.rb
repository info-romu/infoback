class CreateOrderedItems < ActiveRecord::Migration[7.0]
  def change
    create_table :ordered_items do |t|
      t.string :item
      t.integer :price

      t.timestamps
    end
  end
end

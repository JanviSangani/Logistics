class CreateLineItems < ActiveRecord::Migration[5.2]
  def change
    create_table :line_items do |t|
      t.integer :order_id
      t.string :sku
      t.integer :quantity
      t.boolean :original
      t.timestamps
    end
  end
end

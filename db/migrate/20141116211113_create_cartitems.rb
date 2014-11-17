class CreateCartitems < ActiveRecord::Migration
  def change
    create_table :cartitems do |t|
      t.references :cart, index: true
      t.references :item, index: true
      t.integer :review_quality_rating
      t.integer :review_quantity_rating
      t.text :review_comment
      t.float :quantity
      t.integer :price
      t.string :item_name

      t.timestamps
    end
  end
end

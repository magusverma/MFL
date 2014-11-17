class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.integer :clubid
      t.references :user, index: true
      t.string :name
      t.text :description
      t.references :master_cart, index: true

      t.timestamps
    end
  end
end

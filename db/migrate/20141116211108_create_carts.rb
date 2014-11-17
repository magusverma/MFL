class CreateCarts < ActiveRecord::Migration
  def change
    create_table :carts do |t|
      t.references :restaurant, index: true
      t.string :restaurant_name
      t.references :user, index: true
      t.string :user_name
      t.references :club, index: true
      t.string :club_status
      t.float :bill_amount
      t.float :service_tax
      t.float :vat
      t.float :other_tax
      t.string :building_no
      t.string :area
      t.string :city
      t.integer :pincode
      t.string :contact
      t.text :address
      t.string :lock
      t.string :status
      t.string :message

      t.timestamps
    end
  end
end

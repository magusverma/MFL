class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :location
      t.text :about
      t.integer :min_bill
      t.time :start_time
      t.time :end_time
      t.string :photo_url
      t.float :rating
      t.integer :rating_count
      t.integer :loved_by,default: 0

      t.timestamps
    end
  end
end

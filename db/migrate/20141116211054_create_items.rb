class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :name
      t.integer :price
      t.references :category, index: true
      t.references :restaurant, index: true
      t.integer :rating
      t.string :photo_url
      t.time :time_start_avail
      t.time :time_end_avail

      t.timestamps
    end
  end
end

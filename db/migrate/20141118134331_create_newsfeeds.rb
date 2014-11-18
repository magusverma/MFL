class CreateNewsfeeds < ActiveRecord::Migration
  def change
    create_table :newsfeeds do |t|
      t.text :story
      t.references :user, index: true
      t.references :club, index: true
      t.references :restaurant, index: true
      t.references :cart, index: true
      t.timestamps
    end
  end
end

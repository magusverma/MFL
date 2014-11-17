class CreateClubchats < ActiveRecord::Migration
  def change
    create_table :clubchats do |t|
      t.references :club, index: true
      t.references :user, index: true
      t.references :cart, index: true
      t.text :message
      t.integer :likes
      t.integer :dislike

      t.timestamps
    end
  end
end

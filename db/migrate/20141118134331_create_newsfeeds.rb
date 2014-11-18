class CreateNewsfeeds < ActiveRecord::Migration
  def change
    create_table :newsfeeds do |t|
      t.text :story
      t.references :user, index: true

      t.timestamps
    end
  end
end

class CreateApplingos < ActiveRecord::Migration
  def change
    create_table :applingos do |t|
      t.text :line
      t.string :context
      t.string :page

      t.timestamps
    end
  end
end

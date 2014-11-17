class CreateAppcolors < ActiveRecord::Migration
  def change
    create_table :appcolors do |t|
      t.integer :value
      t.string :tag
      t.string :context
      t.string :page

      t.timestamps
    end
  end
end

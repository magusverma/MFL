class CreateAnnouncements < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.boolean :active
      t.string :context
      t.text :details

      t.timestamps
    end
  end
end

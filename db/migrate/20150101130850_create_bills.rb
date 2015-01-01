class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.references :club
      t.references :cart
      t.string :type
      t.text :email
      t.text :sms
      t.text :html

      t.timestamps
    end
  end
end

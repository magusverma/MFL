class AddColumnsToUser < ActiveRecord::Migration
  def change
    add_column :users, :image, :string
    add_column :users, :phone, :string
    add_column :users, :address, :string
    add_column :users, :email, :string
    add_column :users, :guid, :integer
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
  end
end

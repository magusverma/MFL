class Clubchat < ActiveRecord::Base
  belongs_to :club
  belongs_to :user
  belongs_to :cart
end

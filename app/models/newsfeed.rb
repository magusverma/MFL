class Newsfeed < ActiveRecord::Base
  belongs_to :user
  belongs_to :club
  belongs_to :restaurant
  belongs_to :cart

      # t.text :story
      # t.references :user, index: true
      # t.references :club, index: true
      # t.references :restaurant, index: true
      # t.references :cart, index: true

end

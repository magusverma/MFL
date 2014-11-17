class Item < ActiveRecord::Base
  belongs_to :category
  belongs_to :restaurant
  has_many :cartitems
  validates :restaurant_id, :uniqueness => {:scope => [:name]}
end

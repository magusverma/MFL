class Cartitem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :item
  validates :cart_id, :uniqueness => {:scope => [:item_id]}

end

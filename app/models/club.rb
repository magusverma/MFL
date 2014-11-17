class Club < ActiveRecord::Base
  belongs_to :user
  belongs_to :master_cart
end

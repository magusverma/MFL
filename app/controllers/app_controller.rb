class AppController < ApplicationController
  layout "app"
  before_action :user_vars

  def user_vars
    @cui = current_user_image
    @cun = current_user_name
  end

  def handle_order
    "order"=>{"8"=>"1", "9"=>"1", "7"=>"1"}, "commit"=>"Create Order", "rest_name"=>"chicago_pizza"
    u = current_user
    if u.nil? 
      redirect_to :back , :notice => "Invalid User Session"
    end

    r = Restaurant.get_restaurant(params["rest_name"])
    if r.nil? 
      redirect_to :back , :notice => "Invalid Restaurant"
    end
    
    c = Cart.new()
    c.restaurant = r
    c.user = u
    if params["commit"].eql?"Create Order"

    else
      c.club 
    end 
  #       belongs_to :restaurant
  # belongs_to :user
  # belongs_to :club
  # has_many :clubchats
  # has_many :cartitems
  # validates :restaurant_id, :uniqueness => {:scope => [:club_id,:user_id]}
    
  end

  def dashboard
  end

  def restaurants
  end
  
  def foodlanes
  end
  
  def trending
  end
  
  def big_orders
  end
  
  def preferences
  end
  
  def foodlane_help
  end

  def restaurant_info
    bla
  end

  def place_order
    @current_restaurant = Restaurant.get_restaurant(params["rest_name"]).get_rest
  end

  def confirm_order
  end

  def see_order
  end

  def see_foodlane
  end

  def user_profile
  end
end

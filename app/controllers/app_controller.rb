class AppController < ApplicationController
  layout "app"
  before_action :user_vars

  def user_vars
    @cui = current_user_image
    @cun = current_user_name
  end

  def handle_order
    redirect_to :back
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

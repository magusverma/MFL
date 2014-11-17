class AppController < ApplicationController
  layout "app"

  def dashboard
    @cui = current_user_image
    @cun = current_user_name
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

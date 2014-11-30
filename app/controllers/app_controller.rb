class AppController < ApplicationController
  layout "app"
  before_action :user_vars

  def user_vars
    @cui = current_user_image
    @cun = current_user_name
  end

  def handle_order
    # "order"=>{"8"=>"1", "9"=>"1", "7"=>"1"}, "commit"=>"Create Order", "rest_name"=>"chicago_pizza"
    u = current_user
    if u.nil? 
      redirect_to :back , :notice => "Invalid User Session"
    end

    r = Restaurant.get_restaurant(params["rest_name"])
    if r.nil? 
      redirect_to :back , :Club.get_active_clubnotice => "Invalid Restaurant"
    end
    
    c = nil
    if not params["commit"].eql?"Create Order"
      clb = Club.get_active_club(r)
      c = clb.carts.where(:user => u).take
      if c.nil?
        c = Cart.create(:restaurant => r,:user => u,:club => clb)
      end
    else
      c = Cart.create(:restaurant => r,:user => u)
    end 
    if c.remove_all_items()
      params["order"].each do |item,quantity| 
        c.add_item(item.to_i,quantity.to_i)
      end
    else
      redirect_to :back,:notice => "Couldn't Update Cart"
    end     
    c.save
    c.club.update_completed if not c.club.nil?
    @cart = c
    @bill = @cart.get_bill
    session[:cart_id] = c.id
  end

  def confirm
    cart = Cart.find(session[:cart_id])
    if cart.nil?
      redirect_to :back,:notice => "Couldn't Find Active Cart"
    else
      cart.user_name = params[:cart][:user_name]
      cart.contact = params[:cart][:contact]  
      cart.address = params[:cart][:address]  
      cart.expires = Time.now + params[:cart][:time].to_i*60
    end
    cart.club_status = "donedanadonedara"
    cart.save
    redirect_to :dashboard,:notice => "Succesfully Created Order"
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

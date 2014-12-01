class PublicController < ApplicationController
  layout "public"
  def rootpage
    redirect_to dashboard_url if user_signed_in?
  end

  def about
  end

  def contact
  end

  def help
  end

  def careers
  end

  def joinus
  end
end

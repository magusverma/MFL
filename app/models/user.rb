class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :carts


  def get_active_carts
    self.carts.where(:lock =>nil).where("expires > ?",Time.now)
  end

  def set_default_role
    if User.count == 0
      self.role ||= :admin
    else
      self.role ||= :user
    end
  end

  def self.create_with_omniauth(auth)
    create! do |user|
      user.provider = auth['provider']
      user.uid = auth['uid']
      user.image = auth['info']['image']
      user.email = auth['info']['email']
      user.first_name = auth['info']['first_name']
      user.last_name = auth['info']['last_name']
      if auth['info']
         user.name = auth['info']['name'] || ""
      end
    end
  end
end

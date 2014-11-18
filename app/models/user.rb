class User < ActiveRecord::Base
  enum role: [:user, :vip, :admin]
  after_initialize :set_default_role, :if => :new_record?
  has_many :carts


  def get_active_carts
    self.carts.where(:lock =>nil).where("expires > ?",Time.now).where("club_id not ?",nil)
  end

  def get_active_carts_percent_status
    carts = self.get_active_carts
    ps = []
    carts.each do |c|
      h = Hash.new
      h[:name] = c.restaurant.name
      h[:percent] = c.get_percent
      if h[:percent] > 100
        h[:percent] = 100
      end
      h[:club] = c.club.id
      h[:ends] = c.expires - Time.now
      ps.push(h)
    end
    return ps
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

class Club < ActiveRecord::Base
  # belongs_to :user
	has_many :carts
	belongs_to :restaurant
	has_many :clubchats
	# belongs_to :user
	# has_one :master_cart
	after_create :post_news

	def post_news
		Newsfeed.create({story:"foodlane",club: self,user: self.user,restaurant: self.carts.first.restaurant})
		# Newsfeed.create({story: self.user.name.to_s+" has started a foodlane in "+self.carts.first.restaurant.name+", <a href='/order/"+self.carts.first.restaurant.get_url_name+"/"+self.id.to_s+"'>Join </a> " ,user: self.user})
	end

	# sum of all verified carts bill
	def bill_amount
		g = get_bills
		print g
		g[:total]
	end

	def add_cart(id)
		c = Cart.where(:id => id)
		if c.count.eql? 0
			return false
		end
		c = c.first
		if c.locked
			return false
		end
		c.update(:club_id => self.id)
	end		

	def remove_cart(id)
		c = Cart.where(:id => id)
		if c.count.eql? 0
			return false
		end
		c = c.first
		if c.locked
			return false
		end
		c.update(:club_id => nil)
	end

	def get_bills
		puts "hi"
		bills = Hash.new
		bills[:total] = 0
		bills[:bills] = Array.new
		self.carts.each_with_index do |c,i|
			b = c.get_bill
			# bills[:bills][i] = c.get_bill
			bills[:bills].push(b)
			bills[:total] += b[:total_bill]
		end
		bills[:goal] = self.carts.first.restaurant.min_bill
		bills[:away] = bills[:goal] - bills[:total]
		bills[:away] = 0 if bills[:away] < 0
		bills[:description] = self.description
		bills
	end

	def get_bill_summary
		bills = Hash.new
		bills[:total] = 0
		# bills[:bills] = Hash.new
		bills[:bills] = Array.new
		self.carts.each_with_index do |c,i|
			b = c.get_bill_summary
			# bills[:bills][i] = c.get_bill_summary
			bills[:bills].push(b)
			bills[:total] += b[:total_bill]
		end
		bills[:goal] = self.carts.first.restaurant.min_bill
		bills[:away] = bills[:goal] - bills[:total]
		bills[:away] = 0 if bills[:away] < 0
		bills[:description] = self.description
		bills
	end

	def lock_all
		self.carts.each do |c|
			c.lock_it
		end
	end
end

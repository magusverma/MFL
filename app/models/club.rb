class Club < ActiveRecord::Base
	has_many :carts
	belongs_to :restaurant
	has_many :clubchats

	def self.get_active_club(restaurant)
		c = Club.where(:restaurant => restaurant).last
		
		if c.nil? or c.completed 
			c = Club.create(:completed => false,:restaurant => restaurant)
		end

		return c
	end

	def update_completed
		if self.bill_amount >= self.restaurant.min_bill
			self.update(:completed => true)
		end
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
		self.carts.where.not(:club_status => nil).each_with_index do |c,i|
			b = c.get_bill
			# bills[:bills][i] = c.get_bill
			bills[:bills].push(b)
			bills[:total] += b[:total_bill]
		end
		bills[:goal] = self.restaurant.min_bill
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
		self.carts.where.not(:club_status => nil).each_with_index do |c,i|
			b = c.get_bill_summary
			# bills[:bills][i] = c.get_bill_summary
			bills[:bills].push(b)
			bills[:total] += b[:total_bill]
		end
		bills[:goal] = self.restaurant.min_bill
		bills[:away] = bills[:goal] - bills[:total]
		bills[:away] = 0 if bills[:away] < 0
		bills[:description] = self.description
		bills
	end

	def lock_all
		self.carts.where.not(:club_status => nil).each do |c|
			c.lock_it
		end
	end
end

class Club < ActiveRecord::Base
  # belongs_to :user
	has_many :carts
	has_many :clubchats
	belongs_to :user
	belongs_to :master_cart

	# sum of all verified carts bill
	def bill_amount
		g = get_bills
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

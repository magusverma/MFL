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

	def send_email
		self.get_active_carts.each do |cart|
		  cart.send_mail
		end
	end

	def get_active_carts
		# club status nil for carts whose address step wasn't completed
		# self.carts.where.not(:club_status => nil).where("? >= ?",:expires,Time.now.utc)
		# carts = self.carts.where.not(:club_status => nil)
		# carts.map! do |cart|
		#     lambda {
		#       return cart if false #cart.expires - Time.now > 0 
		#     }.call
		# end
		# carts
		self.carts.where("pincode > ?",(Time.now.utc.to_i)).where.not(:club_status => nil)
	end

	def get_time
		t = self.get_active_carts.pluck(:pincode).min
		return "" if t.nil?
		secs = t - Time.now.utc.to_i
		mins = secs/60
		secs = secs%60
		return mins.to_s+":"+secs.to_s
	end

	def get_percent
		return ((self.bill_amount*100 ).to_f/(self.restaurant.min_bill).to_f).to_i
	end
	def get_diff
		return [self.restaurant.min_bill - self.bill_amount ,0].max
	end

	def update_completed
		self.get_active_carts.each do |cart|
			Clubchat.create(user: cart.user, cart: cart,club: self, message: "your foodlane just got updated now Rs."+self.get_diff.to_i.to_s+" to go.")
		end
		if self.bill_amount >= self.restaurant.min_bill
			self.get_active_carts.each do |cart|
				Clubchat.create(user: cart.user, cart: cart,club: self, message: "wohoo! your foodlane reached the target, your order has been sent for delivery")
			end
			# Clubchat.create(:club => self,:message => "wohoo! your foodlane reached the target")
			self.update(:completed => true)
			self.lock_all
			return self.generate_bill
		end
	end

	def generate_bill
		if Bill.find_by(:club_id => self.id).nil?
			self.send_email
			# b = Bill.new
			# b.club = self
			# b.type = "club-order"
			# b.email = self.generate_email_bill_content
			# b.sms = self.generate_sms_bill_content
			# b.html = sel.generate_html_bill_content
			# return b.save
		else
			# Already a bill had been generated for this club order
			return false
		end
		# => #<Bill id: nil, club_id: nil, cart_id: nil, type: nil, email: nil, sms: nil, html: nil, created_at: nil, updated_at: nil>
	end

	def generate_email_bill_content
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
		# self.carts.where.not(:club_status => nil).each_with_index do |c,i|
		self.get_active_carts.each_with_index do |c,i|
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
		# self.carts.where.not(:club_status => nil).each_with_index do |c,i|
		self.get_active_carts.each_with_index do |c,i|
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
		# self.carts.where.not(:club_status => nil).each do |c|
		self.get_active_carts.each_with_index do |c,i|
			if not c.lock_it
				puts "ERROR: problem in locking following cart"
				puts c
				return false
			end
		end
	end
end

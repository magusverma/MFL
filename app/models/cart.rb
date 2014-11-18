class Cart < ActiveRecord::Base
  # belongs_to :restaurant
  # belongs_to :user
  # belongs_to :club
  	belongs_to :restaurant
	belongs_to :user
	belongs_to :club
	has_many :clubchats
	has_many :cartitems
	validates :restaurant_id, :uniqueness => {:scope => [:club_id,:user_id]}
	# validates :email, uniqueness: true

	# scope :unexpired , -> { where(rotting: true) }
	
	def expired?
		if self.expires.nil?
			return false
		end
		return Time.now > self.expires
	end

	def lock_it
		if self.locked?
			return true
		end
		# copy_data #happends in calculate_bill
		calculate_bill
		b = self.get_bill

		if ((b[:total_bill] >= self.restaurant.min_bill) and (not b[:address].eql? ",\n,\n, PINCODE:  \n Contact Number: +91-"))
			self.update(:lock => "locked",:status => "accepted",:message => "Registered as Normal Order , order reference Number: NOR#{self.id}")
			return true
		elsif (self.club.bill_amount > self.restaurant.min_bill)
			self.update(:lock => "locked",:status => "accepted",:message => "Registered as a Club Order , order reference Number: CLB#{self.club_id}")
			return true
		else
			self.update(:lock => "locked",:status => "accepted",:message => "Bill Amount not above Minimum Requirement")
			return false
		end
	end

	def get_percent
		calculate_bill
		return ((self.club.bill_amount/self.restaurant.min_bill)*100)
	end

	def locked?
		self.lock.eql? "locked"
	end

	def copy_data
		unless self.locked?
			self.cartitems.each do |ci|
				ci.update(price: ci.item.price,item_name: ci.item.name.to_s)
			end
			self.update(user_name: self.user.try(:name),restaurant_name: self.restaurant.name.to_s)
			return true
		end
		return false
	end

	def calculate_bill
		tax_percent = 0.15
		unless self.locked?
			self.copy_data
			bill = 0

			self.cartitems.each do |ci|
				bill += (ci.price * ci.quantity)
			end
			tax = tax_percent*bill

			self.update(bill_amount: bill,service_tax: tax)
			return true
		end
		return false
	end

	
	def get_bill
		# begin
			unless self.locked?
				copy_data
				calculate_bill
			end

			bo = Hash.new
			# restaurant name: , name: , address: , items:{name,price,quantity} , tax: , bill amount:

			bo[:name] = self.user_name.to_s
			puts self.user.to_json
			# bo[:email] = self.user["email"]
			# bo[:pic] = self.user.image
			bo[:restaurant] = self.restaurant_name.to_s
			bo[:address] = self.building_no.to_s + ",\n" + self.area.to_s + ",\n" + self.city.to_s + ", PINCODE: " + self.pincode.to_s + " \n Contact Number: +91-" + self.contact.to_s
			bo[:items] = Hash.new
			self.cartitems.each do |ci|
				# quantity: 3.0, price: 300, item_name: "Mexican Pizza"
				bo[:items][ci.item_name] = Hash.new
				bo[:items][ci.item_name][:id] = ci.item.id
				bo[:items][ci.item_name][:price] = ci.price
				bo[:items][ci.item_name][:quantity] = ci.quantity.to_i
				bo[:items][ci.item_name][:contribution] = ci.quantity.to_i*ci.price
			end
			
			bo[:tax] = Hash.new
			bo[:tax][:service_tax] = self.service_tax unless self.service_tax.nil?
			bo[:tax][:vat] = self.vat unless self.vat.nil?
			bo[:tax][:other_tax] = self.other_tax unless self.other_tax.nil?
			bo[:tax][:total] = bo[:tax][:service_tax].to_i + bo[:tax][:vat].to_i + bo[:tax][:other_tax].to_i
			bo[:bill_amount] = self.bill_amount
			bo[:total_bill] = bo[:bill_amount] + bo[:tax][:total]
			return bo
		# rescue Exception => e
	 #      bo = Hash.new
	 #      bo[:error] = "Something went wrong!"
	 #    end
	end

	def get_bill_summary
		bo = self.get_bill
		bo.delete(:items)
		bo.delete(:tax)
		bo.delete(:bill_amount)
		return bo
	end

	def add_item(id,quantity)
		if self.locked?
			return false
		else
			if self.id.nil? or Item.where(:id => id).count.eql? 0 or (not quantity.class.eql? Fixnum)
				return false
			end
			ci = Cartitem.create(:cart_id => self.id,:item_id => id,:quantity => quantity)
			return true
		end
	end

	def remove_item(id,quantity)
		if self.locked?
			return false
		else
			if self.id.nil? or Item.where(:id => id).count.eql? 0 or (not quantity.class.eql? Fixnum)
				return false
			end
			ci = Cartitem.where(:cart_id => self.id,:item_id => id)
			
			if ci.count.eql? 0
				return false
			end
			
			ci = ci.first
			ci.update(:quantity => ci.quantity-quantity)
			if ci.quantity <= 0
				ci.destroy
			end
			return true
		end
	end

	def set_quantity(id,quantity)
		if self.locked?
			return false
		else
			if self.id.nil? or Item.where(:id => id).count.eql? 0 or (not quantity.class.eql? Fixnum)
				return false
			end
			ci = Cartitem.where(:cart_id => self.id,:item_id => id)
			
			if ci.count.eql? 0
				return false
			end
			
			ci = ci.first
			ci.update(:quantity => quantity)
			if ci.quantity <= 0
				ci.destroy
			end
			return true
		end
	end

	def start_clubbing(endtime)
		if self.locked? or self.id.nil?
			return false
		else
			if self.club_id.nil?
				self.update(:club => c,:club_status => :confirm,:expires => endtime)
				c = Club.create(user_id: self.user,master_cart_id: self.id)
				return true
			else
				return true #"already clubbing"
			end
		end
	end

	def user_check(id)
		self.user_id.eql? id
	end
end

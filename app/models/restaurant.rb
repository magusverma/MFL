class Restaurant < ActiveRecord::Base
	has_many :items
	has_many :carts
	validates :name, uniqueness: true
	after_validation :url

	def url
		self.url = self.name.downcase.tr(' ', '_')
	end

	def get_url_name
		self.url
	end
	
	def self.get_restaurant(url_name)
		r = Restaurant.where(:url => url_name).take
		return r
	end

	def get_rest
		r = JSON.parse(self.to_json)
		r[:items] = Hash.new
		cats = self.items.group(:category_id).pluck(:category_id)
		cats.each do |c|
			cname = Category.find(c).name
			items = self.items.where(:category_id => c)
			r[:items][cname] = Hash.new
			items.each do |i|
				r[:items][cname][i.name] = JSON.parse(i.to_json)
			end
		end
		return r
	end
end

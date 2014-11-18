class Announcement < ActiveRecord::Base
	after_create :post_news

	def post_news
		Newsfeed.create({story: self.details})
	end
end

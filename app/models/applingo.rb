class Applingo < ActiveRecord::Base
	

	def self.get(key)
		search_result = Applingo.where(context: key).take
		if search_result.nil?
			return ""
		else
			return search_result.line
		end
	end
end

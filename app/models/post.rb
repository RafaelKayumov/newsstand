class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :text, presence: true

	def formatted_creation_date
		#January 1, 2014 by Mark
		
		#created_at.strftime("%F %T")
		created_at.strftime("%B %d, %Y %H:%M")
	end
end

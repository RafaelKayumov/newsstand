class Post < ActiveRecord::Base
	validates :text, presence: true

	def formatted_creation_date
		created_at.strftime("%F %T")
	end
end

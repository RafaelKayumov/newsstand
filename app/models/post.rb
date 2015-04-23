class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :text, presence: true

	def formatted_creation_date
		created_at.strftime("%F %T")
	end
end

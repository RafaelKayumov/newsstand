class Post < ActiveRecord::Base
  validates :title, presence: true
  validates :text, presence: true

  belongs_to :user
  has_many :votes

  def formatted_creation_date
    created_at.strftime("%B %d, %Y %H:%M")
  end

  def user_email
    self.user.email
  end
end

class Post < ActiveRecord::Base
  belongs_to :user, inverse_of: :posts
  has_many :votes, dependent: :destroy, inverse_of: :post

  validates :title, presence: true
  validates :text, presence: true

  scope :foremost, -> { order('rating DESC, created_at DESC') }

  def formatted_creation_date
    created_at.strftime("%B %d, %Y %H:%M")
  end

  def user_email
    self.user.email
  end

  def can_moderate(user)
    self.user_id == user.try(:id)
  end

  def vote(user, visitor_ip)
    user_id = user.try(:id)
    existing_vote = self.votes.select{ |vote|
      (user_id.present? && vote.user_id == user_id) || (!vote.user_id.present? && !user_id.present? && vote.unknown_user_ip == visitor_ip) 
    }.first
    if existing_vote.present?
      existing_vote.destroy
    else
      self.votes.create(user_id: user_id, unknown_user_ip: visitor_ip)
    end
  end
end

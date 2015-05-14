class Post < ActiveRecord::Base
  belongs_to :user, inverse_of: :posts
  has_many :votes, dependent: :destroy, inverse_of: :post
  delegate :email, to: :user

  validates :title, presence: true
  validates :text, presence: true

  scope :foremost, -> { order('rating DESC, created_at DESC') }

  def moderate?(user)
    self.user_id == user.try(:id)
  end

  def vote(user)
    if vote = votes.find_by(user_id: user.id)
      vote.destroy
    else
      votes.create(user_id: user_id)
    end
  end
end

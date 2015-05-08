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
    if !votes.exists?(user_id: user.id)
      votes.create(user_id: user.id)
    else 
      votes.where(user_id: user.id).first.destroy
    end
  end
end

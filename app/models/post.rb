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

  def vote_up(user_id, visitor_ip)
    already_voted = self.votes.any?{ |vote| vote.user_id == user_id || (vote.user_id != user_id && vote.unknown_user_ip == visitor_ip) }
    puts("ALREADY VOTED! #{already_voted}")
    if !already_voted
      if user_id != nil
        self.votes.create(user_id: user_id)
      elsif visitor_ip != nil
        self.votes.create(unknown_user_ip: visitor_ip)
      end
    end
  end
end

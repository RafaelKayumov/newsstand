class Vote < ActiveRecord::Base
  belongs_to :post, counter_cache: :rating, inverse_of: :votes
end

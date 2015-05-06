class AddPostToVotes < ActiveRecord::Migration
  def change
    add_reference :votes, :post, index: true, foreign_key: true
  end
end

class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.string :unknown_user_ip

      t.timestamps null: false
    end
  end
end

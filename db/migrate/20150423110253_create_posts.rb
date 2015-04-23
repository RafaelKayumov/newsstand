class CreatePosts < ActiveRecord::Migration
  def change
    create_table :posts do |t|
      t.text :text
      t.integer :rating

      t.timestamps null: false
    end
  end
end

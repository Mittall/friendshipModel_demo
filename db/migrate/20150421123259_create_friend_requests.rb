class CreateFriendRequests < ActiveRecord::Migration
  def change
    create_table :friend_requests do |t|
      t.integer :requested_user_id
      t.integer :user_id
      t.string :status

      t.timestamps null: false
    end
  end
end

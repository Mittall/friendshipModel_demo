json.array!(@user_friends) do |user_friend|
  json.extract! user_friend, :id, :user_id, :friend_id
  json.url user_friend_url(user_friend, format: :json)
end

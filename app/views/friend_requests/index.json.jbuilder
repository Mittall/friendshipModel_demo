json.array!(@friend_requests) do |friend_request|
  json.extract! friend_request, :id, :requested_user_id, :user_id, :status
  json.url friend_request_url(friend_request, format: :json)
end

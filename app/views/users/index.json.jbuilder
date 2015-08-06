json.array!(@users) do |user|
  json.extract! user, :id, :email, :password, :password_confirmation, :first_name, :last_last, :contact
  json.url user_url(user, format: :json)
end

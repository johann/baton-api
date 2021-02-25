json.extract! group, :id, :name, :description, :lat, :long, :location, :user_id, :created_at, :updated_at
json.coach do
  json.partial! 'users/user', user: group.coach
end
if group.photo_url
  json.photo group.photo_url
else
  json.photo group.placeholder
end
json.members group.users.limit(5).map do |user|
  json.partial! 'users/user', locals: { user: user }
end
json.is_member group.member?(current_user)
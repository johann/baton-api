json.extract! group, :id, :name, :description, :lat, :long, :location, :created_at, :updated_at
# keep as coach so as not to break api
json.head_coach do
  json.partial! 'users/user', user: group.head_coach
end
json.coaches group.coaches.map do |coach|
  json.partial! 'users/user', locals: { user: coach }
end
json.photo group.photo_url
json.photo_attached group.photo_attached
json.members group.members.limit(5).map do |user|
  json.partial! 'users/user', locals: { user: user }
end
json.is_member group.member?(current_user)
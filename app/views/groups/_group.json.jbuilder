json.extract! group, :id, :name, :description, :lat, :long, :photo_url, :user_id, :created_at, :updated_at
json.coach group.coach
if group.profile_picture.attached?
  json.photo_url group.profile_picture.service_url
else
  json.photo_url nil
end
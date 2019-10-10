json.extract! group, :id, :name, :description, :lat, :long, :user_id, :created_at, :updated_at
json.coach group.coach
if group.photo.attached?
  json.photo group.photo.service_url
else
  json.photo nil
end
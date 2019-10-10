json.extract! activity, :id, :title, :description, :lat, :long, :location, :additional_info, :start_date, :end_date, :created_at, :updated_at
if activity.photo.attached?
  json.photo activity.photo.service_url
else
  json.photo nil
end
json.members activity.users.map do |user|
  json.partial! 'users/user', locals: { user: user }
end
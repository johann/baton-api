json.extract! @activity, :id, :title, :description, :lat, :long, :location, :additional_info, :start_date, :end_date, :created_at, :updated_at, :distance, :intensity
if @activity.photo.attached?
  json.photo @activity.photo.service_url.sub(/\?.*/, '')
else
  json.photo @activity.placeholder
end
# why do we have a limit 
# make a db constraint for this
json.members @activity.users.map do |user|
  json.partial! 'users/user', locals: { user: user }
end
json.coach do
  json.partial! 'users/user', user: @activity.group.coach
end
json.group do
  json.extract! @activity.group, :id, :name, :description, :lat, :long, :location, :user_id, :created_at, :updated_at
  json.coach do
      json.partial! 'users/user', user: @activity.group.coach
  end
  if @activity.group.photo.attached?
    json.photo @activity.group.photo.service_url.sub(/\?.*/, '')
  else
    json.photo @activity.group.placeholder
  end
  json.members @activity.group.users.limit(5).map do |user|
      json.partial! 'users/user', locals: { user: user }
  end
end
if @currently_viewing_user
  json.is_attending @activity.member?(current_user)
end

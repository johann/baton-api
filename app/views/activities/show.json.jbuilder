json.extract! @activity, :id, :title, :description, :lat, :long, :location, :additional_info, :start_date, :end_date, :created_at, :updated_at, :distance, :intensity, :short_link
json.photo @activity.photo_url
json.photo_attached @activity.photo_attached
# why do we have a limit 
# make a db constraint for this
json.members @activity.users.map do |user|
  json.partial! 'users/user', locals: { user: user }
end
json.coach do
  json.partial! 'users/user', user: @activity.coach
end
json.group do
  json.extract! @activity.group, :id, :name, :description, :lat, :long, :location, :created_at, :updated_at
  json.coach do
    json.partial! 'users/user', user: @activity.coach
  end
  json.photo @activity.group.photo_url
  json.members @activity.group.members.take(5).map do |user|
      json.partial! 'users/user', locals: { user: user }
  end
end
if @currently_viewing_user
  json.is_attending @activity.member?(current_user)
end

json.extract! activity, :id, :title, :description, :lat, :long, :location, :additional_info, :start_date, :end_date, :created_at, :updated_at, :distance, :intensity, :short_link
json.photo_attached activity.photo_attached
json.photo activity.photo_url
json.members activity.users.limit(5).map do |user|
  json.partial! 'users/user', locals: { user: user }
end
json.coach do
  json.partial! 'users/user', user: activity.group.coach
end
json.is_attending activity.member?(current_user)
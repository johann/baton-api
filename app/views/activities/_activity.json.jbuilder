json.extract! activity, :id, :title, :description, :lat, :long, :location, :photo_url, :additional_info, :start_date, :end_date, :created_at, :updated_at
if activity.profile_picture.attached?
  json.photo_url activity.profile_picture.service_url
else
  json.photo_url nil
end
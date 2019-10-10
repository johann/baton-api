json.(user, :id, :email, :username, :bio)
json.coach user.coach?
if user.profile_picture.attached?
  json.photo_url user.profile_picture.service_url
else
  json.photo_url nil
end

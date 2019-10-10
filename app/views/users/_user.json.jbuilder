json.(user, :id, :email, :username, :bio)
json.coach user.coach?
if user.photo.attached?
  json.photo user.photo.service_url
else
  json.photo nil
end

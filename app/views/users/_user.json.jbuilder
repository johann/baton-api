json.(user, :id, :email, :username, :bio)
json.coach user.coach?
if user.photo.attached?
  json.photo user.photo.service_url.sub(/\?.*/, '')
else
  json.photo user.placeholder
end

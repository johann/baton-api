json.(user, :id, :email, :bio, :full_name)
json.token user.generate_jwt
json.coach user.coach?
if user.photo.attached?
  json.photo user.photo.service_url.sub(/\?.*/, '')
else
  json.photo user.placeholder
end
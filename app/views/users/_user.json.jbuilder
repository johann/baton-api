json.(user, :id, :email, :bio, :full_name, :persona)
json.coach user.coach?
json.photo user.photo_url
json.photo_attached user.photo_attached
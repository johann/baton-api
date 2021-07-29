json.(user, :id, :email, :bio, :full_name, :persona)
json.coach user.is_coach?
json.photo user.photo_url
json.photo_attached user.photo_attached
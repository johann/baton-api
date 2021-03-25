json.(user, :id, :email, :bio, :full_name, :persona)
json.token user.generate_jwt
json.coach user.coach?
json.photo user.photo_url
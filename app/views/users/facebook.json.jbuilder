json.(@user, :id, :email, :bio, :full_name)
json.token @user.generate_jwt
json.coach @user.is_coach?
json.photo @user.photo_url
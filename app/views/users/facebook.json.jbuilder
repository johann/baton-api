json.(@user, :id, :email, :bio, :full_name)
json.token @user.generate_jwt
json.coach @user.coach?
if @user.photo_url
  json.photo @user.photo_url
else
  json.photo @user.placeholder
end
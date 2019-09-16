json.(user, :id, :email, :username)
json.token user.generate_jwt
json.coach user.coach?

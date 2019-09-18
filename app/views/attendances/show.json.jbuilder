json.array! @users do |user|
  json.partial! 'users/user', locals: { user: user }
end
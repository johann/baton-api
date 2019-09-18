json.user do |json|
  json.partial! 'devise/users/user', user: current_user
end
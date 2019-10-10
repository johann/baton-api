ActiveAdmin.register User do
  permit_params :email, :bio, :username, :coach, :admin
end

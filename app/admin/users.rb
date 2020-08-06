ActiveAdmin.register User do
  permit_params :email, :bio, :coach, :admin, :full_name, :persona
end

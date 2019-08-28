ActiveAdmin.register Group do
  permit_params :name, :description, :lat, :long, :photo_url, :user_id
end

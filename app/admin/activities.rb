ActiveAdmin.register Activity do
  permit_params :title, :description, :lat, :long, :photo_url, :additional_info, :group_id, :date
end

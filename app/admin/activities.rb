ActiveAdmin.register Activity do
  permit_params :title, :description, :lat, :long, :location, :photo_url, :additional_info, :group_id, :start_date, :end_date
end

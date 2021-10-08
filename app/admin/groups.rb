ActiveAdmin.register Group do
  permit_params :name, :description, :lat, :long, :location
end

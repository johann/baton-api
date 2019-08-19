ActiveAdmin.register Membership do
  permit_params :group_id, :user_id
end

class RunMigrations < ActiveRecord::Migration[5.2]
  def change
    change_column_null :groups, :user_uuid, false
    change_column_null :activities, :group_uuid, false
  
    change_column_null :memberships, :user_uuid, false
    change_column_null :memberships, :group_uuid, false

    change_column_null :attendances, :activity_uuid, false
    change_column_null :attendances, :user_uuid, false


    remove_column :groups, :user_id
    remove_column :activities, :group_id
  
    remove_column :memberships, :user_id
    remove_column :memberships, :group_id
    remove_column :attendances, :user_id
    remove_column :attendances, :activity_id
  
    rename_column :groups, :user_uuid, :user_id
    rename_column :activities, :group_uuid, :group_id
  
    rename_column :memberships, :group_uuid, :group_id
    rename_column :memberships, :user_uuid, :user_id
    rename_column :attendances, :activity_uuid, :activity_id
    rename_column :attendances, :user_uuid, :user_id
  end
end

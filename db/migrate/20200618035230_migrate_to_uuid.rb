class MigrateToUuid < ActiveRecord::Migration[5.2]
  def change
    execute <<-SQL
      CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
    SQL
    enable_extension 'pgcrypto'
    add_column :users, :uuid, :uuid, null: false, default: "uuid_generate_v4()"
    add_column :groups, :uuid, :uuid, null: false, default: "uuid_generate_v4()"
    add_column :activities, :uuid, :uuid, null: false, default: "uuid_generate_v4()"
    add_column :attendances, :uuid, :uuid, null: false, default: "uuid_generate_v4()"
    add_column :memberships, :uuid, :uuid, null: false, default: "uuid_generate_v4()"
  
    add_column :groups, :user_uuid, :uuid
    add_column :activities, :group_uuid, :uuid
  
    add_column :attendances, :activity_uuid, :uuid
    add_column :attendances, :user_uuid, :uuid

    add_column :memberships, :group_uuid, :uuid
    add_column :memberships, :user_uuid, :uuid

    execute <<-SQL
      UPDATE groups SET user_uuid = users.uuid
      FROM users WHERE groups.user_id = users.id
    SQL

    execute <<-SQL
      UPDATE activities SET group_uuid = groups.uuid
      FROM groups WHERE activities.group_id = groups.id
    SQL

    execute <<-SQL
      UPDATE attendances SET user_uuid = users.uuid
      FROM users WHERE attendances.user_id = users.id 
    SQL

    execute <<-SQL
      UPDATE attendances SET activity_uuid = activities.uuid
      FROM activities WHERE attendances.activity_id = activities.id 
    SQL

    execute <<-SQL
      UPDATE memberships SET user_uuid = users.uuid
      FROM users WHERE memberships.user_id = users.id
    SQL

    execute <<-SQL
      UPDATE memberships SET group_uuid = groups.uuid
      FROM groups WHERE memberships.group_id = groups.id
    SQL
  end
end
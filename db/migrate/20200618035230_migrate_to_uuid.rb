class MigrateToUuid < ActiveRecord::Migration[5.2]
  def up
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

    add_index :groups, :user_id
    add_foreign_key :groups, :users

    add_index :activities, :group_id
    add_foreign_key :activities, :groups

    add_index :memberships, :user_id
    add_foreign_key :memberships, :users

    add_index :memberships, :group_id
    add_foreign_key :memberships, :groups

    add_index :attendances, :user_id
    add_foreign_key :attendances, :users

    add_index :memberships, :activity_id
    add_foreign_key :memberships, :activities

    remove_column :users, :id
    remove_column :groups, :id
    remove_column :activities, :id
    remove_column :memberships, :id
    remove_column :attendances, :id

    rename_column :users, :uuid, :id
    rename_column :groups, :uuid, :id
    rename_column :activities, :uuid, :id
    rename_column :memberships, :uuid, :id
    rename_column :attendances, :uuid, :id

    execute "ALTER TABLE users    ADD PRIMARY KEY (id);"
    execute "ALTER TABLE groups ADD PRIMARY KEY (id);"
    execute "ALTER TABLE activities ADD PRIMARY KEY (id);"
    execute "ALTER TABLE memberships ADD PRIMARY KEY (id);"
    execute "ALTER TABLE attendances ADD PRIMARY KEY (id);"

    add_index :users, :created_at
    add_index :groups, :created_at
    add_index :activities, :created_at
    add_index :attendances, :created_at
    add_index :membership, :created_at
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
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
      FROM groups WHERE groups.user_id = groups.id
    SQL

    execute <<-SQL
      UPDATE attendances SET user_uuid = users.uuid
      FROM users INNER JOIN activities ON users.activity_id=activities.activity_id
    SQL

    execute <<-SQL
      UPDATE attendances SET activity_uuid = activities.uuid
      FROM users INNER JOIN activities ON users.activity_id=activities.activity_id
    SQL

    execute <<-SQL
      UPDATE memberships SET user_uuid = users.uuid
      FROM users INNER JOIN groups ON users.group_id=groups.group_id
    SQL

    execute <<-SQL
      UPDATE memberships SET group_uuid = groups.uuid
      FROM users INNER JOIN groups ON users.group_id=groups.group_id
    SQL

    # change_column_null :groups, :user_uuid, false
    # change_column_null :activities, :group_uuid, false

    # remove_column :groups, :user_id
    # remove_column :activities, :group_id
    # rename_column :groups, :user_uuid, :user_id
    # rename_column :activities, :group_uuid, :group_id

    # add_index :groups, :user_id
    # add_foreign_key :groups, :users

    # add_index :activities, :group_id
    # add_foreign_key :activities, :groups

    # remove_column :users, :id
    # remove_column :groups, :id
    # remove_column :activities, :id
  
    # rename_column :users, :uuid, :id
    # rename_column :groups, :uuid, :id
    # rename_column :activities, :uuid, :id

    # execute "ALTER TABLE users    ADD PRIMARY KEY (id);"
    # execute "ALTER TABLE groups ADD PRIMARY KEY (id);"
    # execute "ALTER TABLE activities ADD PRIMARY KEY (id);"

    # add_index :users, :created_at
    # add_index :groups, :created_at
    # add_index :activities, :created_at
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end


# create_table "attendances", force: :cascade do |t|
#   t.bigint "activity_id"
#   t.bigint "user_id"
#   t.datetime "created_at", null: false
#   t.datetime "updated_at", null: false
#   t.index ["activity_id"], name: "index_attendances_on_activity_id"
#   t.index ["user_id"], name: "index_attendances_on_user_id"
# end
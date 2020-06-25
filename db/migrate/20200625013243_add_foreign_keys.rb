class AddForeignKeys < ActiveRecord::Migration[5.2]
  def change
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


    execute "ALTER TABLE users ADD PRIMARY KEY (id);"
    execute "ALTER TABLE groups ADD PRIMARY KEY (id);"
    execute "ALTER TABLE activities ADD PRIMARY KEY (id);"
    execute "ALTER TABLE memberships ADD PRIMARY KEY (id);"
    execute "ALTER TABLE attendances ADD PRIMARY KEY (id);"

    add_index :users, :created_at
    add_index :groups, :created_at
    add_index :activities, :created_at
    add_index :attendances, :created_at
    add_index :memberships, :created_at
  end
end


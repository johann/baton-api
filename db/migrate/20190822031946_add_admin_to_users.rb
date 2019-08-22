class AddAdminToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :coach, :boolean
    add_column :users, :admin, :boolean
  end
end

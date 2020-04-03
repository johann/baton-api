class AddFaccebookToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :facebook_linked, :boolean, default: false
    add_column :users, :facebook_data, :jsonb, default: '{}'
  end
end

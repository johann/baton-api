class AddProfileFieldsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :image, :string
    add_column :users, :bio, :text
    add_column :users, :username, :text
  end
end

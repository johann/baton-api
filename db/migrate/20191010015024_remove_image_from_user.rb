class RemoveImageFromUser < ActiveRecord::Migration[5.2]
  def change
    remove_column :users, :image
    remove_column :groups, :photo_url
    remove_column :activities, :photo_url
  end
end

class AddPhotoAttachedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :photo_attached, :boolean
    add_column :activities, :photo_attached, :boolean
    add_column :groups, :photo_attached, :boolean
  end
end

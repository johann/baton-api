class AddLocationToActivityCategory < ActiveRecord::Migration[5.2]
  def change
    change_table :activity_categories do |t|
      t.decimal :lat
      t.decimal :long
      t.string :photo_url
      t.string :additional_info
      t.references :group, foreign_key: true
    end
  end
end

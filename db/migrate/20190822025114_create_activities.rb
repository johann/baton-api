class CreateActivities < ActiveRecord::Migration[5.2]
  def change
    create_table :activities do |t|
      t.string :title
      t.string :description
      t.decimal :lat
      t.decimal :long
      t.string :photo_url
      t.string :additional_info
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end

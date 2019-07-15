class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|
      t.text :name
      t.text :description
      t.decimal :lat
      t.decimal :long
      t.decimal :photo_url
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

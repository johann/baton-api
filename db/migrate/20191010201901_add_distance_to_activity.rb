class AddDistanceToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :distance, :string
  end
end

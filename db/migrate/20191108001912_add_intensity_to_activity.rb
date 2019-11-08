class AddIntensityToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :intensity, :integer
  end
end

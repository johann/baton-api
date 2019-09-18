class AddTimeToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :date, :datetime
  end
end

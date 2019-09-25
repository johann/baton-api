class RenameDateOnActivities < ActiveRecord::Migration[5.2]
  def change
    rename_column :activities, :date, :start_date
    add_column :activities, :end_date, :datetime
  end
end

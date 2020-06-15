class AddIndexToSearchableActivities < ActiveRecord::Migration[5.2]
  def change
  end
#   disable_ddl_transaction!

#   def change
#     add_index :activities, :searchable, using: :gin, algorithm: :concurrently
#   end
end

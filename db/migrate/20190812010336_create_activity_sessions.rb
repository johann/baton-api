class CreateActivitySessions < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_sessions do |t|
      t.datetime :time
      t.references :activity_category, foreign_key: true

      t.timestamps
    end
  end
end

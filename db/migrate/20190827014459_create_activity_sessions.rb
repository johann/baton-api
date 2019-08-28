class CreateActivitySessions < ActiveRecord::Migration[5.2]
  def change
    create_table :activity_sessions do |t|
      t.references :activity, foreign_key: true
      t.datetime :time

      t.timestamps
    end
  end
end

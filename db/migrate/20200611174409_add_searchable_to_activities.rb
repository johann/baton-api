class AddSearchableToActivities < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      ALTER TABLE activities
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('english', coalesce(title, '')), 'A') ||
        setweight(to_tsvector('english', coalesce(description,'')), 'B') ||
        setweight(to_tsvector('english', coalesce(location,'')), 'C')
      ) STORED;
    SQL
  end

  def down
    remove_column :activities, :searchable
  end
end

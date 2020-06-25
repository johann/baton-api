class AddTsvectorColumns < ActiveRecord::Migration[5.2]
  def up
    add_column :activities, :tsv, :tsvector
    add_index :activities, :tsv, using: "gin"

    execute <<-SQL
      CREATE TRIGGER tsvectorupdate BEFORE INSERT OR UPDATE
      ON activities FOR EACH ROW EXECUTE PROCEDURE
      tsvector_update_trigger(
        tsv, 'pg_catalog.english', location, description, title
      );
    SQL

    now = Time.current.to_s(:db)
    update("UPDATE activities SET updated_at = '#{now}'")
  end

  def down
    execute <<-SQL
      DROP TRIGGER tsvectorupdate
      ON activities
    SQL

    remove_index :activities, :tsv
    remove_column :activities, :tsv
  end
end

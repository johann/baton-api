class AddLinkToActivity < ActiveRecord::Migration[5.2]
  def change
    add_column :activities, :short_link, :string
  end
end

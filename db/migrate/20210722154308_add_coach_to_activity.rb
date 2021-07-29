class AddCoachToActivity < ActiveRecord::Migration[5.2]
  def change
    add_reference :activities, :user_id, foreign_key: true, type: :uuid
  end
end

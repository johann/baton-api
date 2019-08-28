class Group < ApplicationRecord
  belongs_to :coach, class_name: "User", foreign_key: :user_id
  has_many :activities
end

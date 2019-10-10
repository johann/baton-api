class Group < ApplicationRecord
  belongs_to :coach, class_name: "User", foreign_key: :user_id
  has_many :activities
  has_many :memberships
  has_many :users, through: :memberships
  has_one_attached :photo
end

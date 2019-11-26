class Group < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  belongs_to :coach, class_name: "User", foreign_key: :user_id
  has_many :activities
  has_many :memberships
  has_many :users, through: :memberships
  has_one_base64_attached :photo

  def has_member?(user)
    users.exists?(user.id)
  end
end

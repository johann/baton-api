class Group < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  belongs_to :coach, class_name: "User", foreign_key: :user_id
  has_many :activities
  has_many :memberships
  has_many :users, -> { distinct }, through: :memberships
  has_one_base64_attached :photo

  def member?(user)
    users.exists?(user.id)
  end

  def placeholder
    "https://batonapprunner.s3.amazonaws.com/group-and-activity-image-placeholder.png"
  end
end

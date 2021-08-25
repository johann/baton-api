class Group < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  # belongs_to :head_coach, class_name: "User", foreign_key: :user_id
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

  def photo_url
    if photo_attached
      "https://baton-app-images.s3.amazonaws.com/groups/#{id}"
    else
      placeholder
    end
  end

  def coaches
    memberships.filter_map { |membership| membership.user if membership.role == 1 }
  end

  def head_coach
    members = memberships.select { |membership| membership.role == 2 }
    members.first.user
  end

  def members
    memberships.select { |membership| membership.role == 0 }
  end
end

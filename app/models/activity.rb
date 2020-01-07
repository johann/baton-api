class Activity < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  belongs_to :group
  has_many :attendances
  has_many :users, -> { distinct }, through: :attendances

  has_one_base64_attached :photo
  default_scope { order(start_date: :desc) }
  enum intensity: [:leisure, :fitness, :competitiveness]

  def member?(user)
    users.exists?(user.id)
  end
end

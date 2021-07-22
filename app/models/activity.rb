class Activity < ApplicationRecord
  include ActiveStorageSupport::SupportForBase64
  include PgSearch::Model
  belongs_to :group
  belongs_to :coach, class_name: "User", foreign_key: :user_id
  has_many :attendances
  has_many :users, -> { distinct }, through: :attendances

  has_one_base64_attached :photo
  default_scope { order(start_date: :desc) }
  enum intensity: [:leisure, :fitness, :competitiveness]
  # pg_search_scope :search_activity,
  #                 against: { title: 'A', description: 'B', location: 'C' },
  #                 using: {
  #                   tsearch: {
  #                     dictionary: 'english', tsvector_column: 'searchable'
  #                   }
  #                 }
  pg_search_scope(
    :search_activity,
    against: %i(
      title
      description
      location
    ),
    using: {
      tsearch: {
        dictionary: "english",
      }
    }
  )

  def member?(user)
    users.exists?(user.id)
  end

  def placeholder
    "https://batonapprunner.s3.amazonaws.com/group-and-activity-image-placeholder.png"
  end

  def photo_url
    if photo_attached
      "https://baton-app-images.s3.amazonaws.com/activities/#{id}"
    else
      placeholder
    end
  end
end

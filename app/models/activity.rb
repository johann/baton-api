class Activity < ApplicationRecord
  belongs_to :group
  has_many :attendances
  has_many :users, through: :attendances

  has_one_attached :photo
  default_scope { order(start_date: :desc) }
  enum intensity: [:leisure, :fitness, :competitiveness]
end

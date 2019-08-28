class ActivitySession < ApplicationRecord
  belongs_to :activity
  has_many :attendances
  has_many :activity_sessions, through: :attendances
end

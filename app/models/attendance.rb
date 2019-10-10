class Attendance < ApplicationRecord
  belongs_to :activity
  belongs_to :user
  validates_uniqueness_of :activity_id, :scope => :user_id
end

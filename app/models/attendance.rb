class Attendance < ApplicationRecord
  belongs_to :user
  belongs_to :activity_session
end

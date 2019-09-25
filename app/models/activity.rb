class Activity < ApplicationRecord
  belongs_to :group
  has_many :attendances
  has_many :users, through: :attendances

  default_scope { order(start_date: :desc) }
end

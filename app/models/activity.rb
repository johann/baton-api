class Activity < ApplicationRecord
  belongs_to :group
  has_many :attendances
  has_many :users, through: :attendances
end

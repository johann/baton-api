# frozen_string_literal: true

FactoryBot.define do
  factory :activity  do
    title 'runners'
    lat 10.342
    long -13.234
    location 'Lower East Side'
    description 'run run everywhere'
    start_date '10am'
    end_date '11am'

    association :group, factory: :group
  end
end
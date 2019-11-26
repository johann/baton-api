# frozen_string_literal: true

FactoryBot.define do
  factory :group do
    name 'runners'
    lat 10.342
    long -13.234
    location 'Lower East Side'
    description 'run run everywhere'

    trait :with_user do
      after(:create) do |group|
        group.users << create(:user)
      end
    end

    association :coach, factory: :user
  end
end
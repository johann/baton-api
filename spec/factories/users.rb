# frozen_string_literal: true
require 'faker'

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    bio 'a good dev'
    username { Faker::Name.unique.first_name }
    password 'password1@'

    trait :coach do
      coach true
    end

    trait :admin do
      admin true
    end
  end
end

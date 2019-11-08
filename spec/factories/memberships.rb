# frozen_string_literal: true

FactoryBot.define do
  factory :membership do
    association :user, factory: :user
    association :group, factory: :group
  end
end
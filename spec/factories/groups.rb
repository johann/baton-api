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
  end
end

# t.text "name"
# t.text "description"
# t.decimal "lat"
# t.decimal "long"
# t.bigint "user_id"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.index ["user_id"], name: "inde
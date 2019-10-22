# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email 'johann@baton.com'
    bio 'a good dev'
    username 'johann'
    password 'password1@'

    trait :coach do
      coach true
    end

    trait :admin do
      admin true
    end
  end
end

# t.string "email", default: "", null: false
# t.string "encrypted_password", default: "", null: false
# t.string "reset_password_token"
# t.datetime "reset_password_sent_at"
# t.datetime "remember_created_at"
# t.integer "sign_in_count", default: 0, null: false
# t.datetime "current_sign_in_at"
# t.datetime "last_sign_in_at"
# t.inet "current_sign_in_ip"
# t.inet "last_sign_in_ip"
# t.datetime "created_at", null: false
# t.datetime "updated_at", null: false
# t.string "image"
# t.text "bio"
# t.text "username"
# t.boolean "coach"
# t.boolean "admin"
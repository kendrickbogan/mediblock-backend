# frozen_string_literal: true

FactoryBot.define do
  factory :sharing_event_code do
    sharing_event
    sequence(:email) { |n| "email+#{n}@example.com" }
  end
end

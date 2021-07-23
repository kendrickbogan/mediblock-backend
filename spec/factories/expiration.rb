# frozen_string_literal: true

FactoryBot.define do
  factory :expiration do
    expires_at { 5.years.from_now }
  end
end

# frozen_string_literal: true

FactoryBot.define do
  factory :person do
    user

    sequence(:first_name) { |n| "John #{n}" }
    last_name { "Adams" }
    legal_gender { "male" }

    trait(:with_address) do
      home_address_line_1 { "27 Bryant Street" }
      home_address_city { "Revere" }
      home_address_state { "MA" }
      home_address_zip { "02151" }
      home_address_country { CS.countries[:US] }
      mailing_address_same_as_home { true }
    end

    trait(:with_birth_info) do
      date_of_birth { 35.years.ago }
      place_of_birth_city { "Boston" }
      place_of_birth_country { CS.countries[:US] }
      country_of_citizenship { CS.countries[:US] }
    end
  end
end

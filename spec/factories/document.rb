# frozen_string_literal: true

FactoryBot.define do
  factory :document do
    person
    sequence(:name) { |n| "Document #{n}" }
    category { "general_information" }
    attachment { Rack::Test::UploadedFile.new("spec/test_upload.jpg", "image/jpg") }

    after(:create) do |document, _|
      create(
        :expiration,
        expirable: document,
        person: document.person,
        expirable_type: "Document"
      )
    end
  end
end

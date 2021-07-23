# frozen_string_literal: true

FactoryBot.define do
  factory :sharing_event do
    person
    sent_from_email { "sender@example.com" }
    recipient_emails { ["recipient_1@example.com", "recipient_2@example.com"] }
    categories_included { ["general_information"] }
    uuid { SecureRandom.uuid }

    trait :with_attachment do
      zip_file { Rack::Test::UploadedFile.new("spec/test_zip.zip", "application/zip") }
    end
  end
end

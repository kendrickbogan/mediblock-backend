person = Person.create!(
  user: User.create(email: "user@example.com", password: "password", onboarding_status: "onboarding_complete"),
  first_name: "Test",
  last_name: "Testerson",
  maiden_name: "Exampleson",
  suffix: "Jr.",
  legal_gender: 1,
  social_security_number: "020449833",
  home_address_line_1: "123 First Street",
  home_address_line_2: "Apartment 12",
  home_address_line_3: "West Side",
  home_address_city: "Townsville",
  home_address_state: "MA",
  home_address_zip: "02213",
  home_address_country: CS.countries[:US],
  mailing_address_same_as_home: true,
  place_of_birth_city: "Boston",
  place_of_birth_state: "MA",
  place_of_birth_country: CS.countries[:US],
  country_of_citizenship: CS.countries[:US],
  date_of_birth: 32.years.ago
)

MilitaryServiceDetail.create!(
  person: person,
  branch_of_service: "Army",
  started_at: 5.years.ago,
  ended_at: 3.years.ago,
  has_dd214: true
)

PostGraduateTraining.create!(
  person: person,
  institution_name: "Boston University Medical School",
  kind: "internship",
  acgme_accredited: true,
  successfully_completed_program: true,
  attendance_start_date: 10.years.ago,
  attendance_end_date: 8.years.ago
)

document = Document.create!(
  name: "Document 1",
  category: :general_information,
  kind: :other,
  other_kind: "Document",
  profile_section: :personal,
  attachment: Rack::Test::UploadedFile.new("db/seed_data/test_upload.jpg", "image/jpg"),
  person: person,
  expires_at: 5.years.from_now
)

sharing_event = SharingEvent.create!(
  person: person,
  recipient_emails: ["test@example.com"],
  sent_from_email: person.user.email,
  document_ids: [document.id],
  zip_file: Rack::Test::UploadedFile.new("db/seed_data/test_zip.zip", "application/zip")
)

SharingEventCode.create!(
  email: "test@example.com",
  sharing_event: sharing_event
)

Person.create!(
  user: User.create(email: "user2@example.com", password: "password", onboarding_status: "onboarding_complete"),
  first_name: "Test",
  last_name: "Testerson",
  maiden_name: "Exampleson",
  suffix: "Jr.",
  legal_gender: 1,
  social_security_number: "020449833",
  home_address_line_1: "123 First Street",
  home_address_line_2: "Apartment 12",
  home_address_line_3: "West Side",
  home_address_city: "Townsville",
  home_address_state: "MA",
  home_address_zip: "02213",
  home_address_country: CS.countries[:US],
  mailing_address_same_as_home: true,
  place_of_birth_city: "Boston",
  place_of_birth_state: "MA",
  place_of_birth_country: CS.countries[:US],
  country_of_citizenship: CS.countries[:US],
  date_of_birth: 32.years.ago
)

Person.create!(
  user: User.create(email: "user3@example.com", password: "password", onboarding_status: "onboarding_complete"),
  first_name: "Test",
  last_name: "Testerson",
  maiden_name: "Exampleson",
  suffix: "Jr.",
  legal_gender: 1,
  social_security_number: "020449833",
  home_address_line_1: "123 First Street",
  home_address_line_2: "Apartment 12",
  home_address_line_3: "West Side",
  home_address_city: "Townsville",
  home_address_state: "MA",
  home_address_zip: "02213",
  home_address_country: CS.countries[:US],
  mailing_address_same_as_home: true,
  place_of_birth_city: "Boston",
  place_of_birth_state: "MA",
  place_of_birth_country: CS.countries[:US],
  country_of_citizenship: CS.countries[:US],
  date_of_birth: 32.years.ago
)

Person.create!(
  user: User.create(email: "user4@example.com", password: "password", onboarding_status: "onboarding_complete"),
  first_name: "Test",
  last_name: "Testerson",
  maiden_name: "Exampleson",
  suffix: "Jr.",
  legal_gender: 1,
  social_security_number: "020449833",
  home_address_line_1: "123 First Street",
  home_address_line_2: "Apartment 12",
  home_address_line_3: "West Side",
  home_address_city: "Townsville",
  home_address_state: "MA",
  home_address_zip: "02213",
  home_address_country: CS.countries[:US],
  mailing_address_same_as_home: true,
  place_of_birth_city: "Boston",
  place_of_birth_state: "MA",
  place_of_birth_country: CS.countries[:US],
  country_of_citizenship: CS.countries[:US],
  date_of_birth: 32.years.ago
)

Person.create!(
  user: User.create(email: "apple@example.com", password: "password", onboarding_status: "onboarding_complete"),
  first_name: "Apple",
  last_name: "Test",
  maiden_name: "",
  suffix: "Jr.",
  legal_gender: 1,
  social_security_number: "020449833",
  home_address_line_1: "123 First Street",
  home_address_line_2: "Apartment 12",
  home_address_line_3: "West Side",
  home_address_city: "Townsville",
  home_address_state: "MA",
  home_address_zip: "02213",
  home_address_country: CS.countries[:US],
  mailing_address_same_as_home: true,
  place_of_birth_city: "Boston",
  place_of_birth_state: "MA",
  place_of_birth_country: CS.countries[:US],
  country_of_citizenship: CS.countries[:US],
  date_of_birth: 32.years.ago
)

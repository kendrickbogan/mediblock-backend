# frozen_string_literal: true

FactoryBot.define do
  factory :board_certification do
    person

    specialty { "specialty" }
    specialty_rank { "primary" }
    board_certified { true }
    certifying_board_name { "board name" }
    initial_certification_date { 5.years.ago }

    trait(:with_questionnaire) do
      board_certified { false }
      certifying_board_name { nil }
      initial_certification_date { nil }

      after(:create) do |certification, _|
        questionnaire = create(:board_certification_questionnaire, board_certification: certification)
        certification.board_certification_questionnaire = questionnaire
        certification.save
      end
    end
  end
end

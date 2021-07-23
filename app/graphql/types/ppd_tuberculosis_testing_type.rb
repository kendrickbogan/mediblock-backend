# frozen_string_literal: true

module Types
  class PPDTuberculosisTestingType < Types::BaseObject
    field :person, Types::PersonType, null: false

    field :received_bcg_vaccine, Boolean, null: false
    field :tested_in_the_last_year, Boolean, null: false

    field :had_positive_tb_skin_test, Boolean, null: false
    field :tested_more_than_5_years_ago, Boolean, null: false
    field :tested_positive_at, GraphQL::Types::ISO8601DateTime, null: true
    field :year_tested_positive, String, null: true
    field :test_reaction_size, Integer, null: true

    field :had_tb_disease_diagnosis, Boolean, null: false
    field :has_taken_inh_or_rifampin, Boolean, null: false
    field :treatment_completed_more_than_5_years_ago, Boolean, null: true
    field :treatment_completed_at, GraphQL::Types::ISO8601DateTime, null: true
    field :year_treatment_completed, String, null: true
    field :last_chest_xray_at, GraphQL::Types::ISO8601DateTime, null: true

    field :testing_site_name, String, null: true
    field :address_line_1, String, null: true
    field :address_line_2, String, null: true
    field :city, String, null: true
    field :state, String, null: true
    field :zip, String, null: true
    field :ppd_induration, Integer, null: true
    field :ppd_interpretation, Types::PPDInterpretationEnum, null: true
    field :test_date, GraphQL::Types::ISO8601DateTime, null: true
  end
end

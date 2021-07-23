# frozen_string_literal: true

module Mutations
  class UpdatePPDTuberculosisTestingMutation < Mutations::BaseMutation
    null true

    argument :received_bcg_vaccine, Boolean, required: true

    argument :tested_in_the_last_year, Boolean, required: true
    argument :had_positive_tb_skin_test, Boolean, required: true
    argument :tested_more_than_5_years_ago, Boolean, required: true
    argument :tested_positive_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :year_tested_positive, String, required: false
    argument :test_reaction_size, Integer, required: false

    argument :had_tb_disease_diagnosis, Boolean, required: true
    argument :has_taken_inh_or_rifampin, Boolean, required: true
    argument :treatment_completed_more_than_5_years_ago, Boolean, required: false
    argument :treatment_completed_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :year_treatment_completed, String, required: false
    argument :last_chest_xray_at, GraphQL::Types::ISO8601DateTime, required: false

    argument :testing_site_name, String, required: false
    argument :address_line_1, String, required: false
    argument :address_line_2, String, required: false
    argument :city, String, required: false
    argument :state, String, required: false
    argument :zip, String, required: false
    argument :ppd_induration, Integer, required: false
    argument :ppd_interpretation, Types::PPDInterpretationEnum, required: false
    argument :test_date, GraphQL::Types::ISO8601DateTime, required: false

    field :ppd_tuberculosis_testing, Types::PPDTuberculosisTestingType, null: true

    def resolve(attrs)
      if person.present?
        ppd_tuberculosis_testing = person.ppd_tuberculosis_testing || PPDTuberculosisTesting.new(person: person)
        ppd_tuberculosis_testing.update(attrs)

        if ppd_tuberculosis_testing.valid?
          { ppd_tuberculosis_testing: ppd_tuberculosis_testing }
        else
          { ppd_tuberculosis_testing: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end

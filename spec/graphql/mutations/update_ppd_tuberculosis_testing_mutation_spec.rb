# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdatePPDTuberculosisTestingMutation do
  context "with required arguments" do
    it "updates and returns the PPD tuberculosis testing" do
      person = create(:person)

      arguments = OpenStruct.new(
        {
          received_bcg_vaccine: true,
          tested_in_the_last_year: false,
          tested_more_than_5_years_ago: false,
          had_positive_tb_skin_test: false,
          has_taken_inh_or_rifampin: false,
          had_tb_disease_diagnosis: false
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: person.user)
      data = result.fetch("data").fetch("updatePpdTuberculosisTesting")
        .fetch("ppdTuberculosisTesting")

      expect(data["receivedBcgVaccine"]).to eq arguments.received_bcg_vaccine
    end

    context "when a user is not signed in" do
      it "returns an authentication error" do
        arguments = OpenStruct.new(
          {
            received_bcg_vaccine: true,
            tested_in_the_last_year: false,
            tested_more_than_5_years_ago: false,
            had_positive_tb_skin_test: false,
            has_taken_inh_or_rifampin: false,
            had_tb_disease_diagnosis: false
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: nil)
        error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

        expect(error_code).to eq "AUTHENTICATION_ERROR"
      end
    end
  end

  context "with all arguments" do
    it "updates and returns the PPD tuberculosis testing" do
      person = create(:person)

      arguments = OpenStruct.new(
        {
          received_bcg_vaccine: true,
          tested_in_the_last_year: true,
          tested_more_than_5_years_ago: false,
          had_positive_tb_skin_test: false,
          has_taken_inh_or_rifampin: false,
          had_tb_disease_diagnosis: false,
          testing_site_name: "Testing Site",
          address_line_1: "123 Street Road",
          address_line_2: "Unit 2",
          city: "Boston",
          state: CS.states(:US)[:MA],
          zip: "02134",
          ppd_induration: 100,
          ppd_interpretation: "NEGATIVE",
          test_date: 1.year.ago
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: person.user)
      data = result.fetch("data").fetch("updatePpdTuberculosisTesting")
        .fetch("ppdTuberculosisTesting")

      expect(data["testingSiteName"]).to eq arguments.testing_site_name
    end
  end

  def build_mutation(attrs)
    <<-GQL.strip_heredoc
    mutation {
      updatePpdTuberculosisTesting(input: {
        receivedBcgVaccine: #{attrs.received_bcg_vaccine},
        testedInTheLastYear: #{attrs.tested_in_the_last_year},
        testedMoreThan5YearsAgo: #{attrs.tested_more_than_5_years_ago},
        hadPositiveTbSkinTest: #{attrs.had_positive_tb_skin_test},
        hasTakenInhOrRifampin: #{attrs.has_taken_inh_or_rifampin},
        hadTbDiseaseDiagnosis: #{attrs.had_tb_disease_diagnosis},
        #{optional_string('testingSiteName', attrs.testing_site_name)}
        #{optional_string('addressLine1', attrs.address_line_1)}
        #{optional_string('addressLine2', attrs.address_line_2)}
        #{optional_string('city', attrs.city)}
        #{optional_string('state', attrs.state)}
        #{optional_string('zip', attrs.zip)}
        #{optional_integer('ppdInduration', attrs.ppd_induration)}
        #{optional_enum('ppdInterpretation', attrs.ppd_interpretation)}
        #{optional_datetime('testDate', attrs.test_date)}
      })
      {
        ppdTuberculosisTesting {
          receivedBcgVaccine
          testingSiteName
        }
      }
    }
    GQL
  end
end

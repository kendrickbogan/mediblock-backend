# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateInfluenzaVaccinationMutation do
  context "with a valid request" do
    context "when the user has not been vaccinated" do
      it "updates and returns the vaccination record" do
        person =  create(:person)

        arguments = OpenStruct.new(
          {
            has_been_vaccinated: false,
            no_vaccination_comment: "Don't like it"
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateInfluenzaVaccination")
        vaccination = person.influenza_vaccination

        expect(vaccination).to be
        expect(data.dig("influenzaVaccination", "vaccinatedAt")).to be_nil
        expect(data.dig("influenzaVaccination", "noVaccinationComment")).to eq arguments.no_vaccination_comment
      end
    end

    context "when the use has been vaccinated" do
      it "updates and returns the vaccination record" do
        person =  create(:person)

        arguments = OpenStruct.new(
          {
            has_been_vaccinated: true,
            vaccinated_at: 3.months.ago,
            flu_season: "2020",
            facility_name: "CVS"
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateInfluenzaVaccination")
        vaccination = person.influenza_vaccination

        expect(vaccination).to be
        expect(data.dig("influenzaVaccination", "vaccinatedAt")).to eq arguments.vaccinated_at.iso8601
        expect(data.dig("influenzaVaccination", "fluSeason")).to eq arguments.flu_season
        expect(data.dig("influenzaVaccination", "facilityName")).to eq arguments.facility_name
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      arguments = OpenStruct.new(
        {
          has_been_vaccinated: true,
          vaccinated_at: 3.months.ago,
          flu_season: "2020",
          facility_name: "CVS"
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_mutation(attrs)
    <<-GQL.strip_heredoc
    mutation {
      updateInfluenzaVaccination(input: {
        #{optional_datetime('vaccinatedAt', attrs.vaccinated_at)}
        hasBeenVaccinated: #{attrs.has_been_vaccinated},
        noVaccinationComment: "#{attrs.no_vaccination_comment}",
        #{optional_string('fluSeason', attrs.flu_season)}
        #{optional_string('facilityName', attrs.facility_name)}
      })
      {
        influenzaVaccination {
          vaccinatedAt
          hasBeenVaccinated
          noVaccinationComment
          fluSeason
          facilityName
        }
      }
    }
    GQL
  end
end

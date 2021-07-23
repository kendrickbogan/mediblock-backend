# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdatePeerReferenceMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the peer reference record" do
        person =  create(:person)
        position = 1

        arguments = OpenStruct.new(
          {
            first_name: "Peer 1",
            last_name: "Reference 1",
            title: "President",
            degree: "Ph.D.",
            specialty: "Everything",
            relationship: "Best Buds",
            phone_number: "9997865738",
            email_address: "dude@dude.com",
            address_line_1: "123 Person Street",
            city: "Boston",
            state: "MA",
            country: "USA",
            zip: "02151",
            has_worked_with_in_the_past_two_years: true,
            years_known: 10,
            position: position
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updatePeerReference")
        reference = person.peer_references.find_by(position: position)

        expect(reference).to be
        expect(data.dig("peerReference", "firstName")).to eq arguments.first_name
        expect(data.dig("peerReference", "position")).to eq arguments.position
      end
    end

    it "can create a peer reference with a different position" do
      person = create(:person)
      existing_reference = create(:peer_reference, position: 1, person: person)
      position = 2

      arguments = OpenStruct.new(
        {
          first_name: "Peer 2",
          last_name: "Reference 2",
          title: "President",
          degree: "Ph.D.",
          specialty: "Everything",
          relationship: "Best Buds",
          phone_number: "9997865738",
          email_address: "dude@dude.com",
          address_line_1: "123 Person Street",
          city: "Boston",
          state: "MA",
          country: "USA",
          zip: "02151",
          has_worked_with_in_the_past_two_years: true,
          years_known: 10,
          position: position
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: person.user)
      data = result.fetch("data").fetch("updatePeerReference")
      reference = person.peer_references.find_by(position: position)

      expect(PeerReference.count).to eq 2
      expect(reference).to be
      expect(data.dig("peerReference", "firstName")).to eq arguments.first_name
      expect(data.dig("peerReference", "position")).to eq arguments.position
    end
  end

  context "when a user is not signed in" do
    it "return an authentication error" do
      arguments = OpenStruct.new(
        {
          first_name: "Peer 2",
          last_name: "Reference 2",
          title: "President",
          degree: "Ph.D.",
          specialty: "Everything",
          relationship: "Best Buds",
          phone_number: "9997865738",
          email_address: "dude@dude.com",
          address_line_1: "123 Person Street",
          city: "Boston",
          state: "MA",
          country: "USA",
          zip: "02151",
          has_worked_with_in_the_past_two_years: true,
          years_known: 10,
          position: 1
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_mutation(reference_attrs)
    <<-GQL.strip_heredoc
    mutation {
      updatePeerReference(input: {
        firstName: "#{reference_attrs.first_name}",
        lastName: "#{reference_attrs.last_name}",
        title: "#{reference_attrs.title}",
        degree: "#{reference_attrs.degree}",
        specialty: "#{reference_attrs.specialty}",
        relationship: "#{reference_attrs.relationship}",
        phoneNumber: "#{reference_attrs.phone_number}",
        emailAddress: "#{reference_attrs.email_address}",
        addressLine1: "#{reference_attrs.address_line_1}",
        city: "#{reference_attrs.city}",
        state: "#{reference_attrs.state}",
        country: "#{reference_attrs.country}",
        zip: "#{reference_attrs.zip}",
        hasWorkedWithInThePastTwoYears: #{reference_attrs.has_worked_with_in_the_past_two_years},
        yearsKnown: #{reference_attrs.years_known},
        position: #{reference_attrs.position},
      })
      {
        peerReference {
          firstName
          position
        }
      }
    }
    GQL
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateFormCompletionStatusMutation do
  context "with a signed in user" do
    context "when a record doesn't exist for the given profile section" do
      it "creates a new FormCompletion record" do
        status = "IN_PROGRESS"
        profile_section = "PERSONAL"
        category = "GENERAL_INFORMATION"

        result = gql_query(
          query: mutation,
          user: create(:person).user,
          variables: {
            status: status,
            profileSection: profile_section,
            category: category
          }
        )

        form_completion = result
          .fetch("data")
          .fetch("updateFormCompletionStatus")
          .fetch("formCompletion")

        expect(form_completion["status"]).to eq status
        expect(form_completion["profileSection"]).to eq profile_section
        expect(form_completion["category"]).to eq category
      end
    end

    context "when a record already exists for the given profile section" do
      it "updates the form completion record" do
        form_completion = create(
          :form_completion,
          status: "in_progress",
          profile_section: "personal",
          category: "general_information"
        )

        new_status = "COMPLETED"

        result = gql_query(
          query: mutation,
          user: create(:person).user,
          variables: {
            status: new_status,
            profileSection: form_completion.profile_section.upcase,
            category: form_completion.category.upcase
          }
        )

        form_completion = result
          .fetch("data")
          .fetch("updateFormCompletionStatus")
          .fetch("formCompletion")

        expect(form_completion["status"]).to eq new_status
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      status = "IN_PROGRESS"
      profile_section = "PERSONAL"
      category = "GENERAL_INFORMATION"

      result = gql_query(
        query: mutation,
        user: nil,
        variables: {
          status: status,
          profileSection: profile_section,
          category: category
        }
      )

      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def mutation
    <<-GQL.strip_heredoc
      mutation UpdateFormCompletionStatus(
        $status: CompletionStatusEnum!,
        $profileSection: ProfileSectionEnum!,
        $category: DocumentCategoryEnum!
      ) {
        updateFormCompletionStatus(input: {
          status: $status,
          profileSection: $profileSection,
          category: $category
        })
        {
          formCompletion {
            status
            profileSection
            category
          }
        }
      }
    GQL
  end
end

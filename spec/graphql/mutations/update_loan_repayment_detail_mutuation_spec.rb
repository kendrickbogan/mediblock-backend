# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateLoanRepaymentDetailMutation do
  context "with all arguments" do
    it "updates and returns the loan repayment detail" do
      person = create(:person)

      arguments = OpenStruct.new(
        {
          repayment_program_name: "Some Repayment Program",
          name_of_institution: "Some Institution",
          address_line_1: "123 Street Road",
          address_line_2: "Unit 2",
          city: "Boston",
          state: CS.states(:US)[:MA],
          zip: "02134",
          years_worked_for_repayment: 4,
          started_at: 10.years.ago,
          ended_at: 6.years.ago
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: person.user)
      data = result.fetch("data").fetch("updateLoanRepaymentDetail")
      loan_repayment_detail = data.fetch("loanRepaymentDetail")

      expect(loan_repayment_detail["repaymentProgramName"]).to eq arguments.repayment_program_name
      expect(loan_repayment_detail["nameOfInstitution"]).to eq arguments.name_of_institution
      expect(loan_repayment_detail["addressLine1"]).to eq arguments.address_line_1
      expect(loan_repayment_detail["addressLine2"]).to eq arguments.address_line_2
      expect(loan_repayment_detail["city"]).to eq arguments.city
      expect(loan_repayment_detail["state"]).to eq arguments.state
      expect(loan_repayment_detail["zip"]).to eq arguments.zip
      expect(loan_repayment_detail["yearsWorkedForRepayment"]).to eq arguments.years_worked_for_repayment
      expect(loan_repayment_detail["startedAt"]).to eq arguments.started_at.iso8601
      expect(loan_repayment_detail["endedAt"]).to eq arguments.ended_at.iso8601
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      arguments = OpenStruct.new(
        {
          repaymentProgramName: "Some Repayment Program",
          name_of_institution: "Some Institution",
          address_line_1: "123 Street Road",
          address_line_2: "Unit 2",
          city: "Boston",
          state: CS.states(:US)[:MA],
          zip: "02134",
          years_worked_for_repayment: 4,
          started_at: 10.years.ago,
          ended_at: 6.years.ago
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
      updateLoanRepaymentDetail(input: {
        #{optional_string('repaymentProgramName', attrs.repayment_program_name)}
        #{optional_string('nameOfInstitution', attrs.name_of_institution)}
        #{optional_string('addressLine1', attrs.address_line_1)}
        #{optional_string('addressLine2', attrs.address_line_2)}
        #{optional_string('city', attrs.city)}
        #{optional_string('state', attrs.state)}
        #{optional_string('zip', attrs.zip)}
        #{optional_integer('yearsWorkedForRepayment', attrs.years_worked_for_repayment)}
        #{optional_datetime('startedAt', attrs.started_at)}
        #{optional_datetime('endedAt', attrs.ended_at)}
      })
      {
        loanRepaymentDetail {
          repaymentProgramName
          nameOfInstitution
          addressLine1
          addressLine2
          city
          state
          zip
          yearsWorkedForRepayment
          startedAt
          endedAt
        }
      }
    }
    GQL
  end
end

# frozen_string_literal: true

module Mutations
  class UpdateLoanRepaymentDetailMutation < Mutations::BaseMutation
    null true

    argument :repayment_program_name, String, required: false
    argument :name_of_institution, String, required: false
    argument :address_line_1, String, required: false
    argument :address_line_2, String, required: false
    argument :city, String, required: false
    argument :state, String, required: false
    argument :zip, String, required: false
    argument :years_worked_for_repayment, Integer, required: false
    argument :started_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :ended_at, GraphQL::Types::ISO8601DateTime, required: false

    field :loan_repayment_detail, Types::LoanRepaymentDetailType, null: true

    def resolve(args)
      if person.present?
        loan_repayment_detail = person.loan_repayment_detail || LoanRepaymentDetail.new(person: person)
        loan_repayment_detail.update(args)

        if loan_repayment_detail.valid?
          { loan_repayment_detail: loan_repayment_detail }
        else
          { loan_repayment_detail: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end

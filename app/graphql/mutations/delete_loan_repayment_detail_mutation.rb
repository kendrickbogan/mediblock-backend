# frozen_string_literal: true

module Mutations
  class DeleteLoanRepaymentDetailMutation < Mutations::BaseDeletionMutation
    def association_method
      :loan_repayment_detail
    end
  end
end

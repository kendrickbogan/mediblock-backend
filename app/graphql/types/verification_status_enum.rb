# frozen_string_literal: true

module Types
  class VerificationStatusEnum < Types::BaseEnum
    value "PENDING", value: "pending"
    value "APPROVED_VERIFIED", value: "approved_verified"
    value "DENIED_FRAUD", value: "denied_fraud"
    value "DENIED_UNSUPPORTED_ID_TYPE", value: "denied_unsupported_id_type"
    value "DENIED_UNSUPPORTED_ID_COUNTRY", value: "denied_unsupported_id_country"
    value "ERROR_NOT_READABLE_ID", value: "error_not_readable_id"
    value "NO_ID_UPLOADED", value: "no_id_uploaded"
  end
end

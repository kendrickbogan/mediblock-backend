# frozen_string_literal: true

module Types
  class HospitalMembershipStatus < Types::BaseEnum
    value "INACTIVE", value: "inactive"
    value "ACTIVE", value: "active"
    value "PROVISIONAL", value: "provisional"
    value "COURTESY", value: "courtesy"
    value "TEMPORARY", value: "temporary"
  end
end

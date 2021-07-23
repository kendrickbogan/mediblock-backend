# frozen_string_literal: true

module Types
  class CertificationKindEnum < Types::BaseEnum
    value "ACLS"
    value "ATLS"
    value "BLS"
    value "CPR"
    value "COREC", value: "CoreC"
    value "NALS"
    value "NRP"
    value "PALS"
    value "OTHER", value: "other"
  end
end

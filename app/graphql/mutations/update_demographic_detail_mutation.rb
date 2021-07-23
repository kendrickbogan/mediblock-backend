# frozen_string_literal: true

module Mutations
  class UpdateDemographicDetailMutation < Mutations::BaseMutation
    null true

    argument :race, [Types::RaceEnum], required: true
    argument :ethnicity, Types::EthnicityEnum, required: true

    field :demographic_detail, Types::DemographicDetailType, null: true

    def resolve(args)
      if person.present?
        demographic_detail = person.demographic_detail || DemographicDetail.new(person: person)
        demographic_detail.update(args)

        if demographic_detail.valid?
          { demographic_detail: demographic_detail }
        else
          { demographic_detail: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end

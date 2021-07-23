# frozen_string_literaL: true

module Mutations
  class UpdateBoardCertificationMutation < Mutations::BaseMutation
    null true

    argument :specialty, String, required: false
    argument :specialty_rank, Types::SpecialtyRankEnum, required: true
    argument :board_certified, Boolean, required: true
    argument :certifying_board_name, String, required: false
    argument :initial_certification_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :recertification_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :expires_at, GraphQL::Types::ISO8601DateTime, required: false
    argument :board_certification_questionnaire_attributes, Types::CertificationQuestionnaireInput, required: false

    field :board_certification, Types::BoardCertificationType, null: true

    def resolve(args)
      if person.present?
        specialty_rank = args[:specialty_rank]
        certification = person.public_send("#{specialty_rank}_certification") || BoardCertification.new(person: person)

        ActiveRecord::Base.transaction do
          certification.board_certification_questionnaire&.destroy

          if args[:board_certified]
            certification.update(args.except(:board_certification_questionnaire_attributes))
          else
            certification.update(args)
          end
        end

        certification.reload

        if certification.valid?
          { board_certification: certification }
        else
          { board_certification: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end

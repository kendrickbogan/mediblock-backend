# frozen_string_literal: true

module Mutations
  class UpdatePostGraduateTrainingMutation < Mutations::BaseMutation
    null true

    argument :acgme_accredited, Boolean, required: true
    argument :attendance_end_date, GraphQL::Types::ISO8601DateTime, required: false
    argument :attendance_start_date, GraphQL::Types::ISO8601DateTime, required: true
    argument :current_program_director_first_name, String, required: false
    argument :current_program_director_last_name, String, required: false
    argument :director_contact_email, String, required: false
    argument :director_contact_number, String, required: false
    argument :director_during_first_name, String, required: false
    argument :director_during_last_name, String, required: false
    argument :fellowship_kind, String, required: false
    argument :gme_office_email, String, required: false
    argument :gme_office_phone, String, required: false
    argument :gme_office_url, String, required: false
    argument :institution_name, String, required: false
    argument :internship_kind, String, required: false
    argument :kind, Types::PostGraduateTrainingKind, required: true
    argument :program_admin_email, String, required: false
    argument :program_admin_name, String, required: false
    argument :program_admin_phone, String, required: false
    argument :program_director_address_city, String, required: false
    argument :program_director_address_country, String, required: false
    argument :program_director_address_line_1, String, required: false
    argument :program_director_address_line_2, String, required: false
    argument :program_director_address_line_3, String, required: false
    argument :program_director_address_state, String, required: false
    argument :program_director_address_zip, String, required: false
    argument :residency_kind, String, required: false
    argument :successfully_completed_program, Boolean, required: true

    field :post_graduate_training, Types::PostGraduateTrainingType, null: true

    def resolve(post_graduate_training_attrs)
      if person.present?
        kind = post_graduate_training_attrs[:kind]
        post_graduate_training = person.public_send(kind) || PostGraduateTraining.new(person: person)
        post_graduate_training.update(post_graduate_training_attrs)

        if post_graduate_training.valid?
          { post_graduate_training: post_graduate_training }
        else
          { post_graduate_training: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end

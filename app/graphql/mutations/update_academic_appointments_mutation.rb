# frozen_string_literal: true

module Mutations
  class UpdateAcademicAppointmentsMutation < Mutations::BaseMutation
    null true

    argument :academic_appointments_attributes, [Types::AcademicAppointmentInput], required: true

    field :academic_appointments, [Types::AcademicAppointmentType], null: true

    def resolve(academic_appointments_attributes:)
      if person.present?
        ActiveRecord::Base.transaction do
          person.academic_appointments.destroy_all
          person.academic_appointments_attributes = academic_appointments_attributes.map(&:to_h)
          person.save
        end

        if person.valid?
          { academic_appointments: person.academic_appointments }
        else
          { academic_appointments: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end

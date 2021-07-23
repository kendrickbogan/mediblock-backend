# frozen_string_literal: true

module Mutations
  class UpdatePeerReferenceMutation < Mutations::BaseMutation
    null true

    argument :first_name, String, required: true
    argument :last_name, String, required: true
    argument :title, String, required: true
    argument :degree, String, required: true
    argument :specialty, String, required: true
    argument :relationship, String, required: true
    argument :phone_number, String, required: true
    argument :email_address, String, required: true
    argument :address_line_1, String, required: true
    argument :address_line_2, String, required: false
    argument :city, String, required: true
    argument :state, String, required: true
    argument :country, String, required: true
    argument :zip, String, required: true
    argument :has_worked_with_in_the_past_two_years, Boolean, required: true
    argument :years_known, Integer, required: true
    argument :position, Integer, required: true

    field :peer_reference, Types::PeerReferenceType, null: true

    def resolve(reference_attrs)
      if person.present?
        position = reference_attrs[:position]
        peer_reference = person.peer_references.find_by(position: position) || PeerReference.new(person: person)
        peer_reference.update(reference_attrs)

        if peer_reference.valid?
          { peer_reference: peer_reference }
        else
          { peer_reference: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end

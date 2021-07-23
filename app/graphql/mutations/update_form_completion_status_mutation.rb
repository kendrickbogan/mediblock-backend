# frozen_string_literaL: true

module Mutations
  class UpdateFormCompletionStatusMutation < Mutations::BaseMutation
    null true

    argument :status, Types::CompletionStatusEnum, required: true
    argument :profile_section, Types::ProfileSectionEnum, required: true
    argument :category, Types::DocumentCategoryEnum, required: true

    field :form_completion, Types::FormCompletionType, null: true

    def resolve(status:, profile_section:, category:)
      if person.present?
        form_completion = person.form_completions.find_by(profile_section: profile_section) || FormCompletion.new

        form_completion.update(
          status: status,
          profile_section: profile_section,
          category: category,
          person: person
        )

        if form_completion.valid?
          { form_completion: form_completion }
        else
          binding.pry
          { form_completion: nil }
        end
      else
        raise_unauthenticated_error
      end
    end
  end
end

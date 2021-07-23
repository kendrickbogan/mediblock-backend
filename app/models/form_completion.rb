class FormCompletion < ApplicationRecord
  belongs_to :person

  enum category: CATEGEGORY_ENUM, _suffix: "category"
  enum profile_section: PROFILE_SECTIONS_ENUM, _suffix: "profile_section"

  enum status: {
    not_started: "not_started",
    in_progress: "in_progress",
    completed: "completed",
    not_applicable: "not_applicable"
  }

  validates :profile_section, uniqueness: { scope: :person_id }
end

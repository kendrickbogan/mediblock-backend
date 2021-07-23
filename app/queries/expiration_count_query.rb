class ExpirationCountQuery
  def initialize(person)
    @scope = Expiration
      .expiring_within_threshold(person.user.expiration_warning_date)
      .where(person: person)
  end

  def by_category(category = nil)
    scope = if category.present?
              @scope.where(category: category)
            else
              @scope
            end

    scope.group(:category).count
  end

  def by_profile_section(profile_section = nil)
    scope = if profile_section.present?
              @scope.where(profile_section: profile_section)
            else
              @scope
            end

    scope.group(:profile_section).count
  end
end

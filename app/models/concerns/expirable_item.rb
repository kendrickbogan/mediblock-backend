module ExpirableItem
  extend ActiveSupport::Concern

  included do
    has_one :expiration, as: :expirable, dependent: :destroy

    delegate :expires_at, to: :expiration, allow_nil: true
  end

  class_methods do
    def expirable_category(category)
      @expirable_category = category
    end

    def expirable_profile_section(profile_section)
      @expirable_profile_section = profile_section
    end

    def category
      @expirable_category
    end

    def profile_section
      @expirable_profile_section
    end

    def create(attrs)
      new_record = super(attrs.except(:expires_at))
      create_expiration(new_record, attrs)
      new_record
    end

    def create!(attrs)
      new_record = super(attrs.except(:expires_at))
      create_expiration(new_record, attrs)
      new_record
    end

    def create_expiration(new_record, attrs)
      if new_record.valid? && attrs[:expires_at].present?
        new_record.create_expiration(
          person: new_record.person,
          expires_at: attrs[:expires_at],
          category: new_record.determine_category,
          profile_section: new_record.determine_profile_section
        )
      end
    end
  end

  def update(attrs)
    result = super(attrs.except(:expires_at))
    expiration_record = expiration || new_expiration
    update_or_destroy_expiration(expiration_record, attrs[:expires_at])
    result
  end

  def update!(attrs)
    result = super(attrs.except(:expires_at))
    expiration_record = expiration || new_expiration
    update_or_destroy_expiration(expiration_record, attrs[:expires_at])
    result
  end

  def determine_profile_section
    self.class.profile_section || try(:profile_section)
  end

  def determine_category
    self.class.category || try(:category)
  end

  private

  def new_expiration
    build_expiration(
      person: person,
      category: determine_category,
      profile_section: determine_profile_section
    )
  end

  def update_or_destroy_expiration(expiration_record, expires_at = nil)
    if expires_at.present?
      expiration_record.update(expires_at: expires_at)
    else
      expiration_record&.destroy
    end
  end
end

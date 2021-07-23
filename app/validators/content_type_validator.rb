class ContentTypeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value.attached? && value.content_type.in?(content_types)
      record.errors.add(attribute, :content_type, options)
    end
  end

  private

  def content_types
    options.fetch(:in)
  end
end

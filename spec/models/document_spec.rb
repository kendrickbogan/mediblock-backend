require "rails_helper"

RSpec.describe Document do
  describe "validations" do
    it { should allow_content_types(Document::PERMITTED_CONTENT_TYPES).for(:attachment) }

    it { should validate_presence_of :attachment }
    it { should validate_presence_of :category }
    it { should validate_presence_of :name }
    it { should validate_presence_of :person }
  end
end

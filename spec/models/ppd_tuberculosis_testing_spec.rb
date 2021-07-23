require "rails_helper"

RSpec.describe PPDTuberculosisTesting do
  describe "validations" do
    it { should validate_presence_of :person }

    context "when a user had a positive TB test" do
      let(:subject) { PPDTuberculosisTesting.new(had_positive_tb_skin_test: true) }

      it { should validate_presence_of :test_reaction_size }
      it { should validate_presence_of :last_chest_xray_at }

      context "and had a test within the past 5 years" do
        let(:subject) do
          PPDTuberculosisTesting.new(had_positive_tb_skin_test: true, tested_more_than_5_years_ago: false)
        end

        it { should validate_presence_of :tested_positive_at }
        it { should_not validate_presence_of :year_tested_positive }
      end

      context "and had a test more than 5 years ago" do
        let(:subject) do
          PPDTuberculosisTesting.new(had_positive_tb_skin_test: true, tested_more_than_5_years_ago: true)
        end

        it { should_not validate_presence_of :tested_positive_at }
        it { should validate_presence_of :year_tested_positive }
      end

      context "and the user has received treatment for TB" do
        context "and the treatment was completed more than 5 years ago" do
          let(:subject) do
            PPDTuberculosisTesting.new(
              had_positive_tb_skin_test: true,
              has_taken_inh_or_rifampin: true,
              treatment_completed_more_than_5_years_ago: true
            )
          end

          it { should validate_presence_of :year_treatment_completed }
          it { should_not validate_presence_of :treatment_completed_at }
        end

        context "and the treatment was completed less than 5 years ago" do
          let(:subject) do
            PPDTuberculosisTesting.new(
              had_positive_tb_skin_test: true,
              has_taken_inh_or_rifampin: true,
              treatment_completed_more_than_5_years_ago: false
            )
          end

          it { should_not validate_presence_of :year_treatment_completed }
          it { should validate_presence_of :treatment_completed_at }
        end
      end

      context "and the user has NOT received treatment for TB" do
        let(:subject) do
          PPDTuberculosisTesting.new(
            had_positive_tb_skin_test: true,
            has_taken_inh_or_rifampin: false
          )
        end

        it { should_not validate_presence_of :year_treatment_completed }
        it { should_not validate_presence_of :treatment_completed_at }
      end
    end
  end
end

# frozen_string_literal: true

require "rails_helper"

RSpec.describe Mutations::UpdateBoardCertificationMutation do
  context "with a valid request" do
    context "with required argments" do
      it "updates and returns the certification record" do
        person = create(:person)

        arguments = OpenStruct.new(
          {
            specialty: "Opthamology",
            specialty_rank: "PRIMARY",
            board_certified: true,
            certifying_board_name: "Board Name",
            initial_certification_date: 5.years.ago.iso8601,
            expires_at: 1.year.from_now.iso8601
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateBoardCertification")

        expect(person.reload.primary_certification).to be
        expect(data.dig("boardCertification", "specialtyRank")).to eq arguments.specialty_rank
      end

      it "can create a secondary specialty record" do
        person = create(:person)

        arguments = OpenStruct.new(
          {
            specialty: "Opthamology",
            specialty_rank: "SECONDARY",
            board_certified: true,
            certifying_board_name: "Board Name",
            initial_certification_date: 5.years.ago.iso8601,
            expires_at: 1.year.from_now.iso8601
          }
        )

        mutation = build_mutation(arguments)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateBoardCertification")

        expect(person.reload.secondary_certification).to be
        expect(data.dig("boardCertification", "specialtyRank")).to eq arguments.specialty_rank
      end
    end

    context "when the person is not board certified" do
      it "creates a board certification questionnaire record" do
        person = create(:person)

        certification_args = OpenStruct.new(
          {
            specialty: "Opthamology",
            specialty_rank: "PRIMARY",
            board_certified: false,
            certifying_board_name: "Board Name",
            initial_certification_date: 5.years.ago.iso8601,
            expires_at: 1.year.from_now.iso8601
          }
        )
        questionnaire_args = OpenStruct.new(
          {
            has_taken_certification_exam: true,
            has_taken_certification_exam_board_name: "Other Board",
            taken_part_one_part_two_eligible: true,
            taken_part_one_part_two_eligible_board_name: "Another Board",
            planning_to_take_exam: true,
            expected_exam_date: 1.month.from_now.iso8601,
            comments: "Some comments"
          }
        )

        mutation = build_mutation(certification_args, questionnaire_args)

        result = gql_query(query: mutation, user: person.user)
        data = result.fetch("data").fetch("updateBoardCertification")
        questionnaire = person
          .reload
          .primary_certification
          .board_certification_questionnaire

        expect(questionnaire).to be
        expect(data.dig("boardCertification", "specialtyRank")).to eq certification_args.specialty_rank
        expect(data.dig("boardCertification", "boardCertified")).to be false
        expect(data.dig("boardCertification", "boardCertificationQuestionnaire",
                        "expectedExamDate")).to eq questionnaire_args.expected_exam_date
      end

      context "and updates the questionnaire fields" do
        it "successfully updates the questionnaire record" do
          certification = create(:board_certification, :with_questionnaire)

          certification_args = OpenStruct.new(
            {
              specialty: "Opthamology",
              specialty_rank: "PRIMARY",
              board_certified: false,
              certifying_board_name: "Board Name",
              initial_certification_date: 5.years.ago.iso8601,
              expires_at: 1.year.from_now.iso8601
            }
          )
          questionnaire_args = OpenStruct.new(
            {
              has_taken_certification_exam: true,
              has_taken_certification_exam_board_name: "Other Board",
              taken_part_one_part_two_eligible: true,
              taken_part_one_part_two_eligible_board_name: "Another Board",
              planning_to_take_exam: true,
              expected_exam_date: 1.month.from_now.iso8601,
              comments: "Some comments"
            }
          )

          mutation = build_mutation(certification_args, questionnaire_args)

          result = gql_query(query: mutation, user: certification.person.user)
          data = result.fetch("data").fetch("updateBoardCertification")
          questionnaire = certification.reload.board_certification_questionnaire

          expect(questionnaire).to be
          expect(data.dig("boardCertification", "boardCertified")).to be false
          expect(data.dig(
                   "boardCertification",
                   "boardCertificationQuestionnaire",
                   "takenPartOnePartTwoEligibleBoardName"
                 )).to eq questionnaire_args.taken_part_one_part_two_eligible_board_name
        end
      end

      context "and then becomes board certified" do
        it "destroys the questionnaire record" do
          certification = create(:board_certification, :with_questionnaire)

          certification_args = OpenStruct.new(
            {
              specialty: "Opthamology",
              specialty_rank: "PRIMARY",
              board_certified: true,
              certifying_board_name: "Board Name",
              initial_certification_date: 5.years.ago.iso8601,
              expires_at: 1.year.from_now.iso8601
            }
          )

          mutation = build_mutation(certification_args)

          result = gql_query(query: mutation, user: certification.person.user)
          data = result.fetch("data").fetch("updateBoardCertification")
          questionnaire = certification.reload.board_certification_questionnaire

          expect(questionnaire).to_not be
          expect(data.dig("boardCertification", "boardCertified")).to be true
          expect(data.dig("boardCertification", "boardCertificationQuestionnaire")).to be_nil
        end
      end
    end
  end

  context "when a user is not signed in" do
    it "returns an authentication error" do
      arguments = OpenStruct.new(
        {
          specialty: "Opthamology",
          specialty_rank: "PRIMARY",
          board_certified: true,
          certifying_board_name: "Board Name",
          initial_certification_date: 5.years.ago.iso8601,
          expires_at: 1.year.from_now.iso8601
        }
      )

      mutation = build_mutation(arguments)

      result = gql_query(query: mutation, user: nil)
      error_code = result.fetch("errors").fetch(0).fetch("extensions").fetch("code")

      expect(error_code).to eq "AUTHENTICATION_ERROR"
    end
  end

  def build_questionnaire_args(questionnaire_attrs)
    if questionnaire_attrs.present?
      <<-GQL.strip_heredoc
        boardCertificationQuestionnaireAttributes: {
          hasTakenCertificationExam: #{questionnaire_attrs.has_taken_certification_exam},
          hasTakenCertificationExamBoardName: "#{questionnaire_attrs.has_taken_certification_exam_board_name}",
          takenPartOnePartTwoEligible: #{questionnaire_attrs.taken_part_one_part_two_eligible},
          takenPartOnePartTwoEligibleBoardName: "#{questionnaire_attrs.taken_part_one_part_two_eligible_board_name}",
          planningToTakeExam: #{questionnaire_attrs.planning_to_take_exam},
          expectedExamDate: "#{questionnaire_attrs.expected_exam_date}",
        }
      GQL
    end
  end

  def build_mutation(certification_attrs, questionnaire_attrs = nil)
    <<-GQL.strip_heredoc
    mutation {
      updateBoardCertification(input: {
        specialty: "#{certification_attrs.specialty}",
        specialtyRank: #{certification_attrs.specialty_rank},
        boardCertified: #{certification_attrs.board_certified},
        certifyingBoardName: "#{certification_attrs.certifying_board_name}",
        initialCertificationDate: "#{certification_attrs.initial_certification_date}",
        expiresAt: "#{certification_attrs.expires_at}",
        #{build_questionnaire_args(questionnaire_attrs)}
      })
      {
        boardCertification {
          specialtyRank
          boardCertified
          boardCertificationQuestionnaire {
            takenPartOnePartTwoEligibleBoardName
            expectedExamDate
          }
        }
      }
    }
    GQL
  end
end

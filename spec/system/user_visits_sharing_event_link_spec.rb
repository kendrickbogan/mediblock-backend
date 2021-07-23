require "rails_helper"

RSpec.describe "User visits SharingEvent link" do
  context "when the user doesn't have a code like" do
    context "and the user's email is in the list of recipients" do
      it "lets the user request a sharing event code" do
        email = "test@example.com"
        sharing_event = create(:sharing_event, recipient_emails: [email])

        expect do
          visit sharing_event_path(sharing_event.uuid)
          fill_in :email, with: email
          click_on "Submit"
        end.to have_enqueued_mail(SharingEventCodeMailer, :send_auth_code)

        sharing_event_code = SharingEventCode.first
        expect(sharing_event_code.email).to eq email
        expect(page).to have_content "Check your email for a code"
      end
    end

    context "and the user's email is not in the list of recipients" do
      it "displays a not found error to the user" do
        user = create(:user, email: "test@example.com")
        sharing_event = create(:sharing_event, recipient_emails: ["somethingelse@example.com"])

        expect do
          visit sharing_event_path(sharing_event.uuid)
          fill_in :email, with: user.email
          click_on "Submit"
        end.to_not have_enqueued_mail(SharingEventCodeMailer, :send_auth_code)

        expect(SharingEventCode.count).to eq 0
        expect(page).to have_content "Something went wrong"
      end
    end
  end

  context "when the user has an existing code" do
    context "and the code is valid" do
      it "initiates the download" do
        Capybara.current_driver = :rack_test

        email = "test@example.com"
        sharing_event_code = create(
          :sharing_event_code,
          email: email,
          sharing_event: create(:sharing_event, :with_attachment, recipient_emails: [email])
        )

        visit sharing_event_path(sharing_event_code.sharing_event.uuid)
        fill_in :code_email, with: email
        fill_in :code, with: sharing_event_code.code
        click_on "Download"

        expect(page.response_headers["Content-Disposition"])
          .to eq "attachment; filename=\"test_zip.zip\"; filename*=UTF-8''test_zip.zip"

        Capybara.use_default_driver
      end
    end

    context "and the code is expired" do
      it "displays an error to the user" do
        email = "test@example.com"
        sharing_event_code = create(
          :sharing_event_code,
          email: email,
          sharing_event: create(:sharing_event, :with_attachment, recipient_emails: [email]),
          created_at: 1.day.ago
        )

        visit sharing_event_path(sharing_event_code.sharing_event.uuid)
        fill_in :code_email, with: email
        fill_in :code, with: sharing_event_code.code
        click_on "Download"

        expect(page).to have_content "code has expired"
      end
    end
  end
end

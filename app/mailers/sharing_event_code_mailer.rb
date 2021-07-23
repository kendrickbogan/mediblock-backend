# frozen_string_literal: true

class SharingEventCodeMailer < ApplicationMailer
  def send_auth_code
    @sharing_event_code = params[:sharing_event_code]

    mail(
      to: @sharing_event_code.email,
      from: ENV.fetch("MAILER_FROM_EMAIL"),
      subject: "Your Mediblock download code"
    )
  end
end

# frozen_string_literal: true

class SharedDocumentMailer < ApplicationMailer
  def share_document_email
    @sharing_event = params[:sharing_event]
    @person = @sharing_event.person

    mail(
      bcc: @sharing_event.recipient_emails,
      reply_to: @sharing_event.sent_from_email,
      from: ENV.fetch("MAILER_FROM_EMAIL"),
      subject: "Mediblock: #{@person.first_name} has shared some documents with you"
    )
  end
end

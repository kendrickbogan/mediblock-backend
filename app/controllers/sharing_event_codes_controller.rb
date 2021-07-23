class SharingEventCodesController < ApplicationController
  def create
    @sharing_event = SharingEvent.find_by!(uuid: params[:sharing_event_uuid])

    if @sharing_event.recipient_emails.include?(email)
      sharing_event_code = SharingEventCode.create(
        sharing_event: @sharing_event,
        email: email
      )

      SharingEventCodeMailer
        .with(sharing_event_code: sharing_event_code)
        .send_auth_code
        .deliver_later

      flash[:notice] = "Check your email for a code"
    else
      flash[:notice] = "Something went wrong."
    end

    redirect_to sharing_event_path(@sharing_event.uuid)
  end

  private

  def email
    params[:email]
  end
end

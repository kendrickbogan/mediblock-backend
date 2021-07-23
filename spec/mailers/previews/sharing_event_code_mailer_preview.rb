class SharingEventCodeMailerPreview < ActionMailer::Preview
  def send_auth_code
    sharing_event_code = SharingEventCode.first
    sharing_event_code.update(created_at: Time.current)
    SharingEventCodeMailer.with(sharing_event_code: sharing_event_code).send_auth_code
  end
end

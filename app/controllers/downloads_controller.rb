class DownloadsController < ApplicationController
  def show
    sharing_event_code = SharingEventCode.find_by!(
      code: params[:code],
      email: params[:code_email]
    )

    if sharing_event_code.expired?
      flash[:notice] = "That code has expired. Please request a new code"
      redirect_to sharing_event_path(sharing_event_code.sharing_event.uuid)
    else
      zip_file = sharing_event_code.sharing_event.zip_file
      send_data zip_file.download, filename: zip_file.blob.filename.to_s
    end
  end
end

class SharingEventsController < ApplicationController
  layout "sharing_event"

  def show
    @sharing_event = SharingEvent.find_by!(uuid: params[:uuid])
  end
end

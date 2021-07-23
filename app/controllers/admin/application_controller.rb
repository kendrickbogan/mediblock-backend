module Admin
  class ApplicationController < Administrate::ApplicationController
    include Clearance::Controller
    before_action :require_login
    before_action :authorize_user

    # Override this value to specify the number of elements to display at a time
    # on index pages. Defaults to 20.
    # def records_per_page
    #   params[:per_page] || 20
    # end

    private

    def authorize_user
      unless current_user.admin?
        sign_out
        redirect_to sign_in_path
      end
    end
  end
end

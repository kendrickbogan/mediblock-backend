# frozen_string_literal: true

module PdfGenerators
  class ProfileInformation < ActionController::Base
    def initialize(share_event)
      @share_event = share_event
    end

    def render
      content = render_to_string(
        layout: "pdf.html",
        template: "pdfs/profile_information",
        assigns: { share_event: @share_event, person: @share_event.person }
      )

      WickedPdf.new.pdf_from_string(
        content,
        pdf: "pdf_name",
        page_size: "A4",
        margin: { top: "0.5in", bottom: "1in", left: "0.5in", right: "0.5in" },
        header: {
          html: {
            layout: "pdf_header.html"
          }
        }
      )
    end
  end
end

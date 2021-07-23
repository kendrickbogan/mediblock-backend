# frozen_string_literal: true

module ApplicationHelper
  def format_date_month_day_year(datetime)
    datetime.strftime("%m/%d/%y")
  end

  def yes_or_no_text(boolean)
    boolean ? "Yes" : "No"
  end
end
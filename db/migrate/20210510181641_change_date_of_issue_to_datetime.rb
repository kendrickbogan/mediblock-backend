class ChangeDateOfIssueToDatetime < ActiveRecord::Migration[6.1]
  def up
    add_column :professional_licenses, :date_of_issue_new, :timestamp

    ProfessionalLicense.find_each do |license|
      license.update(date_of_issue_new: DateTime.parse(license.date_of_issue))
    end

    change_column_null :professional_licenses, :date_of_issue_new, false
    remove_column :professional_licenses, :date_of_issue
    rename_column :professional_licenses, :date_of_issue_new, :date_of_issue
  end

  def down
    add_column :professional_licenses, :date_of_issue_new, :string

    ProfessionalLicense.find_each do |license|
      license.update(date_of_issue_new: license.date_of_issue)
    end

    change_column_null :professional_licenses, :date_of_issue_new, false
    remove_column :professional_licenses, :date_of_issue
    rename_column :professional_licenses, :date_of_issue_new, :date_of_issue
  end
end

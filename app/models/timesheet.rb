class Timesheet < ApplicationRecord
  validates :date,
            :client,
            :project,
            :project_code,
            :hours,
            :first_name,
            :last_name,
            :billable_rate,
            presence: true
  validates :billable, inclusion: { in: [ true, false ] }

  def self.get_project_ids
    pluck(:project_code).uniq
  end

  def self.get_project_details(project_code)
    timesheets = self.where(project_code: project_code)
    project_details = build_project_details(timesheets)
    return project_details
  end

  private 
  def self.build_project_details(timesheets)
    project_details = {
      id: timesheets.first.project_code,
      project_name: timesheets.first.project,
      client_name: timesheets.first.client,
      total_hours: total_hours(timesheets),
      total_billable_amount: total_billable_amount(timesheets),
      billable_hours: billable_hours(timesheets),
      billable_percentage: billable_percentage(timesheets)
    }
  end

  def self.total_hours(timesheets)
    timesheets.select(:hours).reduce(0.0) {|sum, entry| sum + entry[:hours]}
  end

  def self.total_billable_amount(timesheets)
    timesheets.where(billable: true).select(:billable_rate, :hours).reduce(0.0) {|sum, entry| sum + entry.billable_rate * entry.hours }
  end

  def self.billable_hours(timesheets)
    timesheets.where(billable: true).select(:hours).reduce(0.0) {|sum, entry| sum + entry.hours }
  end

  def self.billable_percentage(timesheets)
    (billable_hours(timesheets) / total_hours(timesheets) * 100).round(1)
  end

end
class Timesheet < ApplicationRecord
  validates :date, :client, :project, :project_code, :hours, :first_name, :last_name, :billable_rate, presence: true
  validates :billable, inclusion: { in: [ true, false ] }

  def self.group_by_project
    pluck(:project_code).uniq
  end

  def self.get_project_details(project_code)
    details = self.where(project_code: project_code)
    project_details = Hash.new
    project_details[:id] = details.first.project_code
    project_details[:project_name] = details.first.project
    project_details[:client_name] = details.first.client
    project_details[:total_hours] = details.select(:hours).reduce(0.0) {|sum, entry| sum + entry[:hours]}
    project_details[:total_billable_amount] = details.where(billable: true).select(:billable_rate, :hours).reduce(0.0) {|sum, entry| sum + entry.billable_rate * entry.hours }
    project_details[:billable_hours] = details.where(billable: true).select(:hours).reduce(0.0) {|sum, entry| sum + entry.hours }
    project_details[:billable_percentage] = (project_details[:billable_hours] / project_details[:total_hours] * 100).round(1)
    return project_details
  end
end
class Timesheet < ApplicationRecord
  validates :date, :client, :project, :project_code, :hours, :first_name, :last_name, :billable_rate, presence: true
  validates :billable, inclusion: { in: [ true, false ] }

  def self.group_by_project
    pluck(:project_code).uniq
  end

  def self.get_client_name(project_code)
    where(project_code: project_code).first.client
  end

  def self.get_project_name(project_code)
    where(project_code: project_code).first.project
  end

  def self.total_hours(project_code)
    select(:project_code).sum(:hours)
  end

  def self.total_billable_hours(project_code)
    where(project_code: project_code, billable: true).sum(:hours)
  end

  def self.billable_percentage(project_code)
    billable_hours = total_billable_hours(project_code)
    total_hours = total_hours(project_code)
    billable_hours / total_hours.to_f * 100
  end

  def self.calculate_billable_amount(project_code)
    billable_hours = total_billable_hours(project_code)
    if self.where(project_code: project_code, billable: true).first.billable_rate.nil?
      rate = 0
    else
      rate = self.where(project_code: project_code, billable: true).first.billable_rate
    end
    billable_hours * rate
  end
end
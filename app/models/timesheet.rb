class Timesheet < ApplicationRecord
  validates :date, :client, :project, :project_code, :hours, :first_name, :last_name, :billable_rate, presence: true
  validates :billable, inclusion: { in: [ true, false ] }

  def self.group_by_project
    require 'pry' ; binding.pry
    select(:id, :project_code, :client, :hours, :billable_rate, :project, :billable).group(:id, :project_code)
  end

  def self.total_hours(client, project_code)
    require 'pry' ; binding.pry
    where(client: client).select(:project_code).group(:project_code).sum(:hours)
  end

  def self.total_billable_hours(client, project)
    where(client: client, project: project, billable: true).sum(:hours)
  end

  def self.billable_percentage(client, project)
    billable_hours = total_billable_hours(client, project)
    total_hours = total_hours(client, project)
    billable_hours / total_hours.to_f * 100
  end

  def self.calculate_billable_amount(client, project, rate)
    billable_hours = total_billable_hours(client, project)
    billable_hours * rate
  end
end
class Timesheet < ApplicationRecord
  validates :date, :client, :project, :project_code, :hours, :billable, :first_name, :last_name, :billable_rate, presence: true
end


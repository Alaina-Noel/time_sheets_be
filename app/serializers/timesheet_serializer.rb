class TimesheetSerializer
  include JSONAPI::Serializer
  attributes :id, :client_name, :project_name, :billable_hours, :billable_rate  
  def self.serialize_timesheets(entries)
    {
      data: 
        entries.group_by_project.map do |project_code|
          Timesheet.get_project_details(project_code)
        end
    }
  end

  def self.new_timesheet(details)
    {
    data: 
      { id: details.project_code,
        type: "timesheet",
        attributes: {
          project_code: details.project_code,
          hours: details.hours,
          first_name: details.first_name,
          last_name: details.last_name,
          billable: details.billable,
          billable_rate: details.billable_rate,
          company_name: details.client,
          project_name: details.project
        }
      }
    }
  end
end
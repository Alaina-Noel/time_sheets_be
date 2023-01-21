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
end
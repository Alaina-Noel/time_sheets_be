class TimesheetSerializer
  include JSONAPI::Serializer
  attributes :id, :client_name, :project_name, :billable_hours, :billable_rate  
  def self.serialize_timesheets(entries)
    {
      data: 
        entries.group_by_project.map do |project_code|
          project_details = Timesheet.get_project_details(project_code)
          {
            id: project_code,
            client_name: project_details[:client_name],
            project_name: project_details[:project_name],
            total_hours: project_details[:total_hours],
            billable_hours: project_details[:billable_hours],
            billable_percentage: project_details[:billable_percentage],
            total_billable_amount: project_details[:total_billable_amount]
          }
        end
    }
  end
end
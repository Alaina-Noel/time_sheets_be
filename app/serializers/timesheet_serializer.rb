class TimesheetSerializer
  include JSONAPI::Serializer
  attributes :id, :client_name, :project_name, :billable_hours, :billable_rate  
  def self.serialize_timesheets(entries)
    {
      data: 
        entries.group_by_project.map do |project_code|
          {
            id: project_code,
            client_name: Timesheet.get_client_name(project_code),
            project_name: Timesheet.get_project_name(project_code),
            total_hours: Timesheet.total_hours(project_code),
            billable_hours: Timesheet.total_billable_hours(project_code),
            billage_percentage: Timesheet.billable_percentage(project_code)
            # billable_amount: Timesheet.calculate_billable_amount(project_code)
          }
        end
    }
  end
end
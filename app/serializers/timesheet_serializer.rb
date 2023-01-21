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
            client_name: Timesheet.project_details[:client_name],
            project_name: Timesheet.project_details[:project_name],
            total_hours: Timesheet.project_details[:total_hours],
            billable_hours: Timesheet.total_billable_hours(project_code),
            billage_percentage: Timesheet.billable_percentage(project_code)
            # billable_amount: Timesheet.calculate_billable_amount(project_code)
          }
        end
    }
  end
end
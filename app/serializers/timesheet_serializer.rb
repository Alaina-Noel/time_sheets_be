class TimesheetSerializer
  include JSONAPI::Serializer
  attributes :id, :client_name, :project_name, :billable_hours, :billable_rate  
  def self.serialize_timesheets(entries)
    {
      data: 
        entries.group_by_project.map do |entry|
          {
            id: entry[:id],
            client_name: entry[:client],
            project_name: entry[:project],
            total_hours: Timesheet.total_hours(entry[:client], entry[:project]),
            billable_hours: Timesheet.total_billable_hours(entry[:client], entry[:project]),
            billage_percentage: Timesheet.billable_percentage(entry[:client], entry[:project]),
            billable_amount: Timesheet.calculate_billable_amount(entry[:client], entry[:project], entry[:billable_rate])
          }
        end
    }
  end
end
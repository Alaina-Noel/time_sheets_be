require "csv"

namespace :load do
  desc 'Read CSV File of Timesheets'
  task timesheets: :environment do
    timesheets_data = CSV.parse(File.read('./db/data/timesheets/timesheets_2023_01_20.csv'), headers: true, header_converters: :symbol).map(&:to_h)

    Timesheet.destroy_all
    
    timesheets_data.each do |entry|
      Timesheet.create!(
                    date: Date.strptime(entry[:date], "%m/%d/%y"),
                    client: entry[:client],
                    project: entry[:project],
                    project_code: entry[:project_code],
                    hours: entry[:hours],
                    billable: entry[:billable].downcase == "yes",
                    first_name: entry[:first_name],
                    last_name: entry[:last_name],
                    billable_rate: entry[:billable_rate])
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('timesheets')
  end
end

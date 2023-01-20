namespace :json_load do
  desc 'Read CSV File of Timesheets'
  task timesheets: :environment do
    timesheets_data = JSON.parse(File.read('./db/data/timesheets/timesheets_2023_01_20.csv'), symbolize_names: true)

    timesheets_data[:data].each do |entry|
      Timesheet.create!(date: entry[:date],
                    client: entry[:client],
                    project: entry[:project],
                    project_code: entry[:project_code],
                    hours: entry[:hours],
                    billable: entry[:billable],
                    first_name: entry[:first_name],
                    last_name: entry[:last_name],
                    billable_date: entry[:billable_date])
    end

    ActiveRecord::Base.connection.reset_pk_sequence!('timesheets')
  end
end

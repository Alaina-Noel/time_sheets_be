class Api::V1::TimesheetsController < ApplicationController
  def index
    render json: TimesheetSerializer.serialize_timesheets(Timesheet.all)
  end

  def create
    new_timesheet_details = params["timesheet"]
    company_info = Timesheet.find_by(project_code: params["timesheet"]["project_code"])
    timesheet = Timesheet.new(
      date: Date.today,
      project_code: new_timesheet_details[:project_code],
      client: company_info.client,
      project: company_info.project,
      hours: new_timesheet_details[:hours],
      billable: new_timesheet_details[:billable],
      first_name: new_timesheet_details[:first_name],
      last_name: new_timesheet_details[:last_name],
      billable_rate: new_timesheet_details[:billable_rate] )
    if timesheet.save
      render json: TimesheetSerializer.new_timesheet(timesheet), status: 201
    else
      render json: { error: "Something went wrong. Check that you have passed in all parameters in the body." }, status: :bad_request
    end
  end
end

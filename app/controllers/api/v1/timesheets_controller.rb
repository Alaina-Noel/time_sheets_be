class Api::V1::TimesheetsController < ApplicationController
  def index
    render json: TimesheetSerializer.serialize_timesheets(Timesheet.all)
  end

  def create
    timesheet_details = params["timesheet"]
    timesheet = Timesheet.new(date: Date.today, project_code: timesheet_details[:project_code], client: timesheet_details[:company_name], project: timesheet_details[:project_name], hours: timesheet_details[:hours], billable: timesheet_details[:billable], first_name: timesheet_details[:first_name], last_name: timesheet_details[:last_name], billable_rate: timesheet_details[:billable_rate] )
    if timesheet.save
      render json: TimesheetSerializer.new_timesheet(timesheet), status: 201
    elsif !timesheet.project_code #|| !timesheet.email
      render json: { error: "You must pass in a body with timesheet data" }, status: :bad_request
    else
      render json: { error: "Someting went wrong. Check that you have passed in all parameters in the body." }, status: :bad_request
    end
  end
end

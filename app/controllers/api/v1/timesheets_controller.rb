class Api::V1::TimesheetsController < ApplicationController

  def index
    render json: TimesheetSerializer.serialize_timesheets(Timesheet.all)
  end

  def create
    timesheet = Timesheet.new(timesheet_params)
    timesheet.client = existing_company_info.client
    timesheet.project = existing_company_info.project
    timesheet.date = Date.today
    if timesheet.save
      render json: TimesheetSerializer.new_timesheet(timesheet), status: :created
    else
      render json: { errors: timesheet.errors }, status: :bad_request
    end
  end

  private
  def existing_company_info
    Timesheet.find_by(project_code: params["timesheet"]["project_code"])
  end

  def timesheet_params
    params.require(:timesheet).permit(:project_code, :hours, :billable, :first_name, :last_name, :billable_rate)
  end

end
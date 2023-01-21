class Api::V1::TimesheetsController < ApplicationController
  def index
    
    render json: TimesheetSerializer.serialize_timesheets(Timesheet.all)
  end
end

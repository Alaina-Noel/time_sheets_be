require 'rails_helper'

describe 'Timehseets API' do
  describe 'timesheet index' do
    describe 'happy path' do
      it 'sends a list of all timesheets with appropriate attributes' do
        Timesheet.destroy_all
        timesheet_1 = create(:timesheet)
        timesheet_2 = create(:timesheet)
        timesheet_3 = create(:timesheet)
        timesheet_4 = create(:timesheet)
        timesheet_5 = create(:timesheet)
        timesheet_6 = create(:timesheet)
        timesheet_7 = create(:timesheet)
        timesheet_8 = create(:timesheet)

        get '/api/v1/timesheets'
        
        expect(response).to be_successful
        
        timesheets = JSON.parse(response.body, symbolize_names: true)

        expect(timesheets[:data].count).to eq(3)

        timesheets[:data].each do |entry|
          expect(entry).to have_key(:id)
          expect(entry[:id]).to be_a(Integer)

          expect(entry).to have_key(:client_name)
          expect(entry[:client_name]).to be_a(String)

          expect(entry).to have_key(:project_name)
          expect(entry[:project_name]).to be_a(String)

          expect(entry).to have_key(:total_hours)
          expect(entry[:total_hours]).to be_a(Float)

          expect(entry).to have_key(:billable_hours)
          expect(entry[:billable_hours]).to be_a(Float)

          expect(entry).to have_key(:billage_percentage)
          expect(entry[:billage_percentage]).to be_a(Float)

          expect(entry).to have_key(:billable_amount)
          expect(entry[:billable_amount]).to be_a(Float)

          expect(entry.keys.count).to eq(7)
         end
      end
    end

    # describe 'sad path' do
    #   it 'sends a helpful error message if the user __________' do
    #     get '/api/v1/timesheets'
    #   end
    # end

    # describe 'sad path' do
    #   it 'sends a helpful error message if there is no data' do
    #     get '/api/v1/timesheets'
    #   end
    # end
  end
end

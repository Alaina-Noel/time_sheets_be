require 'rails_helper'

describe 'Timehseets API' do
  describe 'timesheet index' do
    describe 'happy path' do
      it 'sends a list of all timesheets with appropriate attributes' do
        Timesheet.destroy_all
        entry_1_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 2.75, billable: true, first_name: "POP", last_name: "TART", billable_rate: 80)
        entry_2_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 7.75, billable: true, first_name: "POP", last_name: "TART", billable_rate: 80)
        entry_3_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 7.75, billable: false, first_name: "POP", last_name: "TART", billable_rate: 0)
        entry_1_company_a_project_a2 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 2 Company A", project_code:"A2", hours: 5.0, billable: false, first_name: "POP", last_name: "TART", billable_rate: 0) 
        entry_1_company_b_project_b1 = Timesheet.create!(date: "2023-01-20", client: "Company B Name", project: "Project 1 Company B", project_code:"B1", hours: 6, billable: true, first_name: "POP", last_name: "TART", billable_rate: 100)
        entry_2_company_b_project_b1 = Timesheet.create!(date: "2023-01-20", client: "Company B Name", project: "Project 1 Company B", project_code:"B1", hours: 6.5, billable: true, first_name: "POP", last_name: "TART", billable_rate: 100)
        entry_3_company_b_project_b1 = Timesheet.create!(date: "2023-01-20", client: "Company B Name", project: "Project 1 Company B", project_code:"B1", hours: 6.5, billable: true, first_name: "POP", last_name: "TART", billable_rate: 100)

        get '/api/v1/timesheets'

        expect(response).to be_successful
        
        timesheets = JSON.parse(response.body, symbolize_names: true)

        expect(timesheets[:data].count).to eq(3)

        timesheets[:data].each do |entry|
          expect(entry).to have_key(:id)
          expect(entry[:id]).to be_a(String)

          expect(entry).to have_key(:client_name)
          expect(entry[:client_name]).to be_a(String)

          expect(entry).to have_key(:project_name)
          expect(entry[:project_name]).to be_a(String)

          expect(entry).to have_key(:total_hours)
          expect(entry[:total_hours]).to be_a(Float)

          expect(entry).to have_key(:billable_hours)
          expect(entry[:billable_hours]).to be_a(Float)

          expect(entry).to have_key(:billable_percentage)
          expect(entry[:billable_percentage]).to be_a(Float)

          expect(entry).to have_key(:total_billable_amount)
          expect(entry[:total_billable_amount]).to be_a(Float)

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

require 'rails_helper'

describe 'Timehseets API' do
  describe 'timesheet index' do
    describe 'happy path' do
      it 'sends a list of all timesheets with appropriate attributes' do
        Timesheet.destroy_all
        entry_1_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 2.75, billable: true, first_name: "POP", last_name: "TART", billable_rate: 80)
        entry_2_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 7.75, billable: true, first_name: "POP", last_name: "TART", billable_rate: 80)
        entry_3_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 7.75, billable: false, first_name: "POP", last_name: "TART", billable_rate: 0)


        params = { timesheet: { project_code: "A1", company_name: "Company A Name", project_name: "Project A Company A", hours: 2.5, billable: true, first_name: "Alaina", last_name: "Kneiling", billable_rate: 90 } }
      
        post '/api/v1/timesheets', :params => params, :headers => headers
        
        expect(response).to be_successful
        expect(response.status).to eq(201)
        
        timesheet_data = JSON.parse(response.body, symbolize_names: true)

        expect(timesheet_data).to have_key(:data)
        expect(timesheet_data[:data]).to be_a(Hash)
        expect(timesheet_data[:data]).to have_key(:type)
        expect(timesheet_data[:data]).to have_key(:id)
        expect(timesheet_data[:data]).to have_key(:attributes)

        expect(timesheet_data[:data][:type]).to eq("timesheet")
        expect(timesheet_data[:data][:id].to_i).to be_an(Integer)

        expect(timesheet_data[:data][:attributes]).to have_key(:project_code)
        expect(timesheet_data[:data][:attributes]).to have_key(:hours)
        expect(timesheet_data[:data][:attributes]).to have_key(:billable)
        expect(timesheet_data[:data][:attributes]).to have_key(:first_name)
        expect(timesheet_data[:data][:attributes]).to have_key(:last_name)
        expect(timesheet_data[:data][:attributes]).to have_key(:billable_rate)

        expect(timesheet_data[:data][:attributes][:project_code]).to be_a(String)
        expect(timesheet_data[:data][:attributes][:hours]).to be_a(Float)
        expect(timesheet_data[:data][:attributes][:billable]).to be(true)
        expect(timesheet_data[:data][:attributes][:first_name]).to be_a(String)
        expect(timesheet_data[:data][:attributes][:last_name]).to be_a(String)
        expect(timesheet_data[:data][:attributes][:billable_rate]).to be_an(Integer)
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


#     end
#   end

#   describe 'sad path' do
#     it 'sends back a helpful error message if the request doesnt provide attributes' do

#       headers = { "CONTENT_TYPE" => "application/json" }

#       post '/api/v1/users', :params => '{ "user": { } }', :headers => headers
  
#       expect(response.status).to eq(400)

#       user_data = JSON.parse(response.body, symbolize_names: true)

#       expect(user_data).to have_key(:error)
#       expect(user_data[:error]).to eq("You must pass in a body with user data")
#     end

#     it 'sends back a helpful error message if the user provides mismatch datatypes as attributes' do
#       headers = { "CONTENT_TYPE" => "application/json" }

#       post '/api/v1/users', :params => '{ "user": { "name":"Rebecca Daphne", "email": "Rdaph1@cliffs.com" } }', :headers => headers

#       post '/api/v1/users', :params => '{ "user": { "name":"Elizabeth Daphne", "email": "Rdaph1@cliffs.com" } }', :headers => headers
  
#       expect(response.status).to eq(400)

#       user_data = JSON.parse(response.body, symbolize_names: true)

#       expect(user_data).to have_key(:error)
#       expect(user_data[:error]).to eq('That email address has been taken.')
#     end
#   end
# end
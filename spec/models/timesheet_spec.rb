require 'rails_helper'
RSpec.describe Timesheet, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:date) }
    it { should validate_presence_of(:client) }
    it { should validate_presence_of(:project) }
    it { should validate_presence_of(:project_code) }
    it { should validate_presence_of(:hours) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }
    it { should validate_presence_of(:billable_rate) }
  end

  describe 'class methods' do

    describe '#group_by_project' do
      it 'returns the ids of every unique project' do
        Timesheet.destroy_all

        entry_1_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 2.75, billable: true, first_name: "POP", last_name: "TART", billable_rate: 80)
        entry_2_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 7.75, billable: true, first_name: "POP", last_name: "TART", billable_rate: 80)
        entry_3_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 7.75, billable: false, first_name: "POP", last_name: "TART", billable_rate: 0)
        entry_1_company_a_project_a2 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 2 Company A", project_code:"A2", hours: 5.0, billable: false, first_name: "POP", last_name: "TART", billable_rate: 0) 
        entry_1_company_b_project_b1 = Timesheet.create!(date: "2023-01-20", client: "Company B Name", project: "Project 1 Company B", project_code:"B1", hours: 6, billable: true, first_name: "POP", last_name: "TART", billable_rate: 100)
        entry_2_company_b_project_b1 = Timesheet.create!(date: "2023-01-20", client: "Company B Name", project: "Project 1 Company B", project_code:"B1", hours: 6.5, billable: true, first_name: "POP", last_name: "TART", billable_rate: 100)
        entry_3_company_b_project_b1 = Timesheet.create!(date: "2023-01-20", client: "Company B Name", project: "Project 1 Company B", project_code:"B1", hours: 6.5, billable: true, first_name: "POP", last_name: "TART", billable_rate: 100)

        expect(Timesheet.group_by_project).to eq(["A1", "A2", "B1"])
      end
    end


    describe '#total_billable_hours' do
      it 'returns the total billable hours for a given project_code' do
        Timesheet.destroy_all

        entry_1_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 2.75, billable: true, first_name: "POP", last_name: "TART", billable_rate: 80)
        entry_2_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 7.75, billable: true, first_name: "POP", last_name: "TART", billable_rate: 80)
        entry_3_company_a_project_a1 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 1 Company A", project_code:"A1", hours: 7.75, billable: false, first_name: "POP", last_name: "TART", billable_rate: 0)
        entry_1_company_a_project_a2 = Timesheet.create!(date: "2023-01-20", client: "Company A Name", project: "Project 2 Company A", project_code:"A2", hours: 5.0, billable: false, first_name: "POP", last_name: "TART", billable_rate: 0) 
        entry_1_company_b_project_b1 = Timesheet.create!(date: "2023-01-20", client: "Company B Name", project: "Project 1 Company B", project_code:"B1", hours: 6, billable: true, first_name: "POP", last_name: "TART", billable_rate: 100)
        entry_2_company_b_project_b1 = Timesheet.create!(date: "2023-01-20", client: "Company B Name", project: "Project 1 Company B", project_code:"B1", hours: 6.5, billable: true, first_name: "POP", last_name: "TART", billable_rate: 100)
        entry_3_company_b_project_b1 = Timesheet.create!(date: "2023-01-20", client: "Company B Name", project: "Project 1 Company B", project_code:"B1", hours: 6.5, billable: true, first_name: "POP", last_name: "TART", billable_rate: 100)

        a1_details = { :id => "A1",
                        :project_name => "Project 1 Company A",
                        :client_name => "Company A Name",
                        :total_hours => 18.25,
                        :total_billable_amount => 840.00,
                        :billable_hours => 10.5,
                        :billable_percentage => 57.5
                      }

        expect(Timesheet.get_project_details("A1")).to eq(a1_details)
      end
    end
  end

end
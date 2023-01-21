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

        expect(Timesheet.total_billable_hours("A1")).to eq(10.50)
      end
    end
  end

end
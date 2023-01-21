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
end
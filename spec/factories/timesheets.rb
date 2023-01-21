require 'faker'
FactoryBot.define do
  factory :timesheet do
    date { "2023-01-20" }
    client { ["Company A", "Company B"].sample }
    project { ["Project A", "Project B", "Project C"].sample }
    project_code { "MyString" }
    hours { Faker::Number.between(from: 0.0, to: 8.0).round(2) }
    billable { true }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    billable_rate { Faker::Number.between(from: 1, to: 300) }
  end
end

require 'faker'
FactoryBot.define do
  factory :timesheet do
    date { "2023-01-20" }
    client { ["Company A", "Company B"].sample }
    project { "Project Name" }
    project_code { ["Project A Code", "Project B Code", "Project C Code"].sample }
    hours { Faker::Number.between(from: 0.0, to: 8.0).round(2) }
    billable { [true, false].sample }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    billable_rate { Faker::Number.between(from: 1, to: 300) }
  end
end

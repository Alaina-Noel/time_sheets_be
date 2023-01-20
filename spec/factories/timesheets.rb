FactoryBot.define do
  factory :timesheet do
    date { "2023-01-20" }
    client { "MyString" }
    project { "MyString" }
    project_code { "MyString" }
    hours { 1.5 }
    billable { false }
    first_name { "MyString" }
    last_name { "MyString" }
    string { "MyString" }
    billable_date { 1 }
  end
end

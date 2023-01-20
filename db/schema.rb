ActiveRecord::Schema.define(version: 2023_01_20_173359) do

  enable_extension "plpgsql"

  create_table "timesheets", force: :cascade do |t|
    t.date "date"
    t.string "client"
    t.string "project"
    t.string "project_code"
    t.float "hours"
    t.boolean "billable"
    t.string "first_name"
    t.string "last_name"
    t.string "string"
    t.integer "billable_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end
end
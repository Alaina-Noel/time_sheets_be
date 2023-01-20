class CreateTimesheets < ActiveRecord::Migration[5.2]
  def change
    create_table :timesheets do |t|
      t.date :date
      t.string :client
      t.string :project
      t.string :project_code
      t.float :hours
      t.boolean :billable
      t.string :first_name
      t.string :last_name
      t.string :string
      t.integer :billable_date

      t.timestamps
    end
  end
end

class RemoveStringFromTimesheets < ActiveRecord::Migration[5.2]
  def change
    remove_column :timesheets, :string, :string
  end
end

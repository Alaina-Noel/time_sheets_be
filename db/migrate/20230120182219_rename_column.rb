class RenameColumn < ActiveRecord::Migration[5.2]
  def change
    rename_column :timesheets, :billable_date, :billable_rate
  end
end

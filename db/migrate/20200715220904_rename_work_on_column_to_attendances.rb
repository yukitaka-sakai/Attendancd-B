class RenameWorkOnColumnToAttendances < ActiveRecord::Migration[5.1]
  def change
    rename_column :attendances, :work_on, :worked_on
  end
end

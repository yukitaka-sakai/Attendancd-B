module AttendancesHelper
  
  def attendance_state(attendance)
    if Date.current == attendance.worked_on
      # 勤怠データが当日、かつ出社時間が存在しない場合は”出社”
      return "出社" if attendance.started_at.nil?
      # 勤怠データが当日、かつ出社時間が登録済み、かつ退社時間が存在しない場合に”退社”
      return "退社" if attendance.started_at.present? && attendance.finished_at.nil?
    end
    # 勤怠データが当日ではない、または、当日だが出社時間も退社時間も登録済みの場合”false”
    false
  end
end


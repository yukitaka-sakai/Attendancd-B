class Attendance < ApplicationRecord
  belongs_to :user
  
  validates :worked_on, presence: true
  validates :note, length: { maximum: 50 }
  
  # 出社が存在しない場合、退社時間は無効
  validate :finished_at_is_invalid_without_a_started_at
  # 出社・退社時間がどちらも存在する時、出社時間より早い退社時間は無効
  validate :started_at_than_finished_at_fast_if_invalid
  # validate :only_started_at_is_invalid
  
  
  def finished_at_is_invalid_without_a_started_at
    errors.add(:started_at, "が必要です") if started_at.blank? && finished_at.present?
  end
  
  def started_at_than_finished_at_fast_if_invalid
    if started_at.present? && finished_at.present?
      errors.add(:started_at,"より早い退社時間は無効です") if started_at > finished_at
    end
  end
  
  def only_started_at_is_invalid
    errors.add(:started_at,"のみの編集は無効です") if started_at.present? && finished_at.blank?
  end
  
  # def time_current_than_work_on_is_invalid
  #   if started_at.presetnt? && finished_at.present?
  #     errors.add("未来の編集は無効です") if Date.current < day.worked_on
  #   end
  # end
end

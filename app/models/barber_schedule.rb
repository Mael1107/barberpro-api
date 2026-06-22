class BarberSchedule < ApplicationRecord
  belongs_to :barber_profile

  enum :weekday, {
    sunday: 0, monday: 1, tuesday: 2, wednesday: 3, thursday: 4, friday: 5, saturday: 6
  }

  validates :weekday, presence: true, uniqueness: {scope: :barber_profile_id}
  validates :start_time, :end_time, presence: true
  validate :end_time_after_start_time

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?
    errors.add(:end_time, "must be after start_time") if end_time <= start_time
  end
end

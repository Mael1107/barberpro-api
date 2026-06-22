class Appointment < ApplicationRecord
  belongs_to :client, class_name: "User"
  belongs_to :barber_profile

  has_many :appointment_services, dependent: :destroy
  has_many :services, through: :appointment_services

  enum :status, { pending: 0, confirmed: 1, canceled: 2, done: 3 }, default: :pending

  validates :scheduled_at, presence: true

  def total_duration_minutes
    services.sum(:duration_minutes)
  end

  def total_price
    appointment_services
  end

  def total_price
    appointment_services.sum(:price_at_booking)
  end

  def end_at
    scheduled_at + total_duration_minutes.minutes
  end
end

class AppointmentService < ApplicationRecord
  belongs_to :appointment
  belongs_to :service

  validates :price_at_booking, presence: true, numericality: { greater_than: 0 }
end

class BarberProfile < ApplicationRecord
  belongs_to :user
  has_many :barbers_schedules, dependent: :destroy
  has_many :appointments, dependent: :destroy
  
  validates :user_id, uniqueness: true
  validates :bio, presence: true
end

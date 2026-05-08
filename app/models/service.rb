class Service < ApplicationRecord
  scope :active, -> { where(active: true) }

  validates :name,
    presence: true,
    uniqueness: { case_sensitive: false }

  validates :duration_minutes,
    presence: true,
    numericality: { greater_than: 0, only_integer: true }

  validates :price,
    presence: true,
    numericality: { greater_than: 0 }
end

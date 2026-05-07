class User < ApplicationRecord
  has_secure_password

  enum :role, { client: 0, barber: 1, admin: 2 }, default: :client
  
  validates :name, presence: true
  validates :password, length: {minimum: 6}, if: -> {password.present?}
  validates :email,
    presence: true,
    uniqueness: { case_sensitive: false },
    format: { with: URI::MailTo::EMAIL_REGEXP }
  
  def as_auth_json
    {id: id, name: name, email: email, role: role}
  end

end

class User < ApplicationRecord
	has_secure_password
  validates :username, presence: true, uniqueness: true
  validates :role, presence: true

  enum role: [:admin, :customer, :delivery_partner]
end

class User < ApplicationRecord
	has_secure_password

  validates :username, presence: true, uniqueness: true
  validates :role, presence: true

  before_validation :downcase_city

  enum role: [:admin, :customer, :delivery_partner]

  has_many :shipments_as_customer, class_name: "Shipment", foreign_key: "customer_id"
  has_many :shipments_as_delivery_partner, class_name: "Shipment", foreign_key: "delivery_partner_id"
  has_one :location

  private

  def downcase_city
    self.city = city.downcase if city.present?
  end
end

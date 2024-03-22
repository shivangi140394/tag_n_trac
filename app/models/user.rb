class User < ApplicationRecord
	has_secure_password

  # Associations
  has_many :shipments_as_customer, class_name: "Shipment", foreign_key: "customer_id", dependent: :destroy
  has_many :shipments_as_delivery_partner, class_name: "Shipment", foreign_key: "delivery_partner_id", dependent: :destroy
  has_many :shipments_as_admin, class_name: "Shipment", foreign_key: "admin_id", dependent: :destroy
  has_one :location

  #validations
  validates :username, presence: true, uniqueness: true
  validates :role, presence: true
  validates :pincode, length: { minimum: 5 }
  validates :phone_number, presence: true, format: { with: /\A\d{10}\z/, message: "must be 10 digits" }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }


  #custom validation
  validate :unique_delivery_partner_city

  #callbacks
  before_validation :downcase_city

  enum role: [:admin, :customer, :delivery_partner]


  private

  def downcase_city
    self.city = city.downcase if city.present?
  end

   def unique_delivery_partner_city
    return if self.id.present?
    if delivery_partner? && User.exists?(role: :delivery_partner, city: city)
      errors.add(:city, "has already been taken by another delivery partner.")
    end
  end
end

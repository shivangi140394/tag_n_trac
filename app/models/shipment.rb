class Shipment < ApplicationRecord
  #association
  belongs_to :customer, class_name: "User", optional: true
  belongs_to :delivery_partner, class_name: "User", optional: true
  belongs_to :admin, class_name: "User", optional: true

  #validation
  validates :status, :source_location, :target_location, presence: true

  #custom validation
  validate :target_location_and_user_role_exists

  #callbacks
  before_validation :downcase_target_location

  enum status: [:ordered, :cancelled, :shipped, :delivered]

  private

  def downcase_target_location
    self.target_location = target_location.downcase if target_location.present?
  end

  def target_location_and_user_role_exists
    location_exists = Location.exists?(city: target_location)
    users_in_location = User.exists?(role: :delivery_partner, city: Location.find_by(city: target_location)&.city)

    unless location_exists && users_in_location
      errors.add(:target_location, "is not allowed or no delivery partners are available in this location.")
    end
  end
end
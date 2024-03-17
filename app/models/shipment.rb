class Shipment < ApplicationRecord

  validates :status, presence: true

  enum status: [:ordered, :cancelled, :shipped, :delivered]

  belongs_to :customer, class_name: "User", optional: true
  belongs_to :delivery_partner, class_name: "User", optional: true

  before_validation :downcase_target_location

  private

  def downcase_target_location
    self.target_location = target_location.downcase if target_location.present?
  end
end

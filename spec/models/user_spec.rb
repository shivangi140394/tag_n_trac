require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username) }
    it { should validate_presence_of(:role) }
  end

  describe "Associations" do
    it { should have_many(:shipments_as_customer).class_name("Shipment").with_foreign_key("customer_id") }
    it { should have_many(:shipments_as_delivery_partner).class_name("Shipment").with_foreign_key("delivery_partner_id") }
    it { should have_one(:location) }
  end

  describe "Enums" do
    it { should define_enum_for(:role).with_values([:admin, :customer, :delivery_partner]) }
  end

  describe "Callbacks" do
    it "downcases the city before validation" do
      user = User.new(city: "New York")
      user.valid?
      expect(user.city).to eq("new york")
    end
  end

  describe "Password encryption" do
    it "encrypts the password" do
      user = User.new(username: "testuser", password: "password")
      expect(user.password_digest).not_to be_nil
    end
  end
end

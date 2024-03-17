require 'rails_helper'

RSpec.describe Shipment, type: :model do
  describe "Validations" do
    it { should validate_presence_of(:status) }
  end

  describe "Enums" do
    it { should define_enum_for(:status).with_values([:ordered, :cancelled, :shipped, :delivered]) }
  end

  describe "Associations" do
    it { should belong_to(:customer).class_name("User").optional }
    it { should belong_to(:delivery_partner).class_name("User").optional }
  end

  describe "Callbacks" do
    describe "#downcase_target_location" do
      let(:shipment) { build(:shipment, target_location: "New York") }

      it "downcases the target_location before validation" do
        shipment.valid?
        expect(shipment.target_location).to eq("new york")
      end

      it "does not change the target_location if it's nil" do
        shipment.target_location = nil
        shipment.valid?
        expect(shipment.target_location).to be_nil
      end
    end
  end
end

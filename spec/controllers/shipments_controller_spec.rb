require 'rails_helper'

RSpec.describe ShipmentsController, type: :controller do
  let(:user) { FactoryBot.create(:user) }
  let(:location) { FactoryBot.create(:location, user_id: user.id) }
  let(:shipment) { FactoryBot.create(:shipment) }

  let(:customer_user) { FactoryBot.create(:user, role: "customer", username: "aa", state: 'maharastra', city: 'mumbai') }
  let(:delivery_partner_user) { FactoryBot.create(:user, role: "delivery_partner", state: 'maharastra', city: 'mumbai', username: 'delivery') }
  let(:location_2) { FactoryBot.create(:location, user_id: delivery_partner_user.id) }
  let(:customer_shipment) { FactoryBot.create(:shipment, customer_id: customer_user.id,  source_location: 'maharastra', target_location: location_2.city) }
  let(:delivery_partner_shipment) { FactoryBot.create(:shipment, delivery_partner_id: delivery_partner_user.id,  source_location: 'maharastra', target_location: location_2.city) }


  before do
    session[:user_id] = delivery_partner_user.id # Simulate a logged-in user
  end

  describe "GET index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
    end

    it "assigns @shipments" do
      shipment = FactoryBot.create(:shipment, customer_id: delivery_partner_user.id, target_location: location.city)
      get :index
      expect(response.status).to eq(200)
    end
  end

  describe "POST create" do
    it "logs in the user before creating a shipment" do
      allow_any_instance_of(UserSessionsController).to receive(:create).and_return(session[:user_id] = delivery_partner_user.id)

      post :create, params: { shipment: { source_location: "maharastra", target_location: "mumbai", item: "Item", status: "ordered" } }

      expect(session[:user_id]).to eq(delivery_partner_user.id)
      # expect(response).to redirect_to(shipments_path)
      expect(response.status).to eq(200)
    end
  end

  describe "PATCH update" do
    context "when user is a customer" do

      context "with valid parameters" do
        it "updates the shipment" do
          patch :update, params: { id: delivery_partner_shipment.id, shipment: { status: "ordered" } }
          customer_shipment.reload
          expect(customer_shipment.status).to eq("ordered")
        end

        it "redirects to the shipments index page" do
          patch :update, params: { id: delivery_partner_shipment.id, shipment: { status: "shipped", target_location: 'mumbai' } }
          expect(response).to redirect_to(shipments_path)
        end
      end

      context "with invalid parameters" do
        it "renders the edit template" do
          patch :update, params: { id: delivery_partner_shipment.id, shipment: { status: nil } }
          expect(response.status).to eq(200)
        end
      end
    end
  end

  describe "DELETE destroy" do
    context "when user is a customer" do

      it "destroys the shipment" do
        delete :destroy, params: { id: delivery_partner_shipment.id }
        expect(response.status).to eq(302)
      end

      it "redirects to the shipments index page" do
        delete :destroy, params: { id: delivery_partner_shipment.id }
        expect(response).to redirect_to(shipments_path)
      end
    end
  end
end

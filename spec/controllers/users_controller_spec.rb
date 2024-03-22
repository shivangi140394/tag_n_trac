require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  let(:user) { FactoryBot.create(:user, pincode: 78987, phone_number: 5645656565, address: 'street vally') }

  before do
    session[:user_id] = user.id # Simulate a logged-in user
  end

  describe 'GET #index' do
    it 'not get user due to validation ' do
      user = FactoryBot.create(:user, username: 'aa')
      get :index
      expect(response.status).to eq(302)
    end
  end

  describe 'GET #new' do
    it 'assigns a new user as @user' do
      get :new
      expect(response.status).to eq(200)
    end
  end

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new User' do
        expect {
          post :create, params: { user: {name: 'customer', username: 'customer', password: 'password', password_confirmation: 'password', email: 'customer@example.com', role: 'customer', pincode: 78987, phone_number: 5645656565} }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the root_path' do
        post :create, params: { user: {name: 'customer', username: 'customer', password: 'password', password_confirmation: 'password', email: 'customer@example.com', role: 'customer', pincode: 78987, phone_number: 5645656565 }}
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new User' do
        expect do
          post :create, params: { user: {name: 'customer', username: 'customer', password: 'password', password_confirmation: 'password', email: 'customer@example.com', pincode: 78987, phone_number: 5645656565}}
        end.not_to change(User, :count)
      end
    end
  end
end

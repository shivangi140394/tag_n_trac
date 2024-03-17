require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #index' do
    it 'assigns all users as @users' do
      user = FactoryBot.create(:user)
      get :index
      expect(response).to have_http_status(:success)
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
          post :create, params: { user: {name: 'customer', username: 'customer', password: 'password', password_confirmation: 'password', email: 'customer@example.com', role: 'customer'} }
        }.to change(User, :count).by(1)
      end

      it 'redirects to the root_path' do
        post :create, params: { user: {name: 'customer', username: 'customer', password: 'password', password_confirmation: 'password', email: 'customer@example.com', role: 'customer' }}
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid params' do
      it 'does not create a new User' do
        expect do
          post :create, params: { user: {name: 'customer', username: 'customer', password: 'password', password_confirmation: 'password', email: 'customer@example.com'}}
        end.not_to change(User, :count)
      end
    end
  end
end

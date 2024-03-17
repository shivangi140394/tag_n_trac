FactoryBot.define do
  factory :user do
    name { 'Test User' }
    username { 'testuser' }
    password { 'password' }
    password_confirmation { 'password' }
    email { 'test@example.com' }
    role { 'customer' }
  end
end
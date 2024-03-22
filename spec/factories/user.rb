FactoryBot.define do
  factory :user do
    name { 'Test User' }
    username { 'testuser' }
    password { 'password' }
    password_confirmation { 'password' }
    email { 'test@example.com' }
    role { 'customer' }
    pincode { 23456 }
    phone_number { 1234567898 }
    state { 'maharastra' }
    city { 'mumbai' }
  end
end
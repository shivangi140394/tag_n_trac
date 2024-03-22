FactoryBot.define do
  factory :shipment do
    source_location { 'maharastra' }
    target_location { 'mumbai' }
    item { 'electronic' }
    status { 'ordered' }
    address { 'order@example.com' }
  end
end
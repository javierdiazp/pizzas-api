FactoryBot.define do
  factory :store do
    name { Faker::Restaurant.name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    phone { Faker::PhoneNumber.cell_phone }
  end
end

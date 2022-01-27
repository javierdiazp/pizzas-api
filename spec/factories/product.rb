FactoryBot.define do
  factory :product do
    name { Faker::Food.ingredient }
    sku { Faker::Barcode.isbn }
    type { %w[Pizza Complement].sample }
    price { Faker::Number.between(from: 5, to: 200) * 100 }
  end
end

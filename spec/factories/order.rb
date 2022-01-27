FactoryBot.define do
  factory :order do
    association :store
    total { 0 }
  end
end

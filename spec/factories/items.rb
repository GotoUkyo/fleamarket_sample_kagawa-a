FactoryBot.define do
  factory :item do
    name { "MyString" }
    description { "MyText" }
    brand { "MyString" }
    state_id { 1 }
    postage_id { 1 }
    area_id { 1 }
    day_id { 1 }
    price { 1 }
    deal_state_id { 1 }
    user_id { 1 }
    category_id { 1 }
  end
end

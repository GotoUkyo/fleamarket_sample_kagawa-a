FactoryBot.define do
  factory :item do
    name             {"かまくら"}
    description      {"かまくら"}
    brand            {"NIKE"}
    state_id         { 01 }
    postage_id       { 01 }
    prefecture_id    { 01 }
    day_id           { 01 }
    price            { 1000 }
    deal_state_id    { 0 }
  end
end

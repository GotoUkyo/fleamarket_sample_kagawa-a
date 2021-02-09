FactoryBot.define do
  factory :item do
    name             {"かまくら"}
    description      {"かまくら"}
    brand            {"高松市"}
    state_id         {"123"}
    postage_id       { 01 }
    prefecture_id    { 01 }
    day_id           { 01 }
    price            { 1000 }
    # deal_state_id
  end
end

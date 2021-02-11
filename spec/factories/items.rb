FactoryBot.define do
  factory :item do
    name             {"かまくら"}
    description      {"かまくら"}
    state_id         { 1 }
    postage_id       { 1 }
    prefecture_id    { 1 }
    day_id           { 1 }
    price            { 1000 }
    deal_state_id    { 0 }
    user
    after(:build) do |item|
      item.images << build(:image)
    end
  end
end

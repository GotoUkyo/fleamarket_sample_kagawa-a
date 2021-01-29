FactoryBot.define do

  factory :address do
    postcode           {"000-0000"}
    prefecture_id      { 01 }
    city               {"高松市"}
    block              {"123"}
  end
end
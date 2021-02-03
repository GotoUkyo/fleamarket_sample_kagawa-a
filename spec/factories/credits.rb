FactoryBot.define do
  factory :credit do
    user_id { 1 }
    customer_id { "MyString" }
    card_id { "MyString" }
    string { "MyString" }
  end
end

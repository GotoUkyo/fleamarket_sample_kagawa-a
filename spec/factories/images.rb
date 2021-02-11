FactoryBot.define do
  factory :image do
    name { File.open("#{Rails.root}/public/images/IMG_6768.jpeg") }
  end
end

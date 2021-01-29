FactoryBot.define do

  factory :user do
    nick_name              {"dai"}
    email                 {"sample@gmail.com"}
    password              {"1234567"}
    password_confirmation {"1234567"}
    last_name           {"鎌倉"}
    first_name            {"大祐"}
    last_name_kana      {"カマクラ"}
    first_name_kana       {"ダイスケ"}
    birthday             {"1983-02-05"}
  end
end
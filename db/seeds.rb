# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


# 商品購入機能動作確認ようにitemsテーブルにデータ追加（rails db:seed）
Item.create!(name: 'お宝', description: '見ちゃだめ', brand: '', state_id: 1, postage_id: 1, area_id: 1, day_id: 1, price: 5000, deal_state_id: 0, user_id: 2, category_id: 1)
Item.create!(name: '鉛筆', description: 'イタリアで買ったものです', brand: '', state_id: 1, postage_id: 1, area_id: 1, day_id: 1, price: 2000, deal_state_id: 0, user_id: 2, category_id: 1)
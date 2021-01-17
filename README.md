# README

## usersテーブル
|Column|Type|Options|
|------|----|-------|
|nick_name|string|null: false, unique: true|
|email|string|null: false, unique: true|
|password|string|null: false|
|last_name|string|null: false|
|first_name|string|null: false|
|last_name_kana|string|null: false|
|first_name_kana|string|null: false|
|birthday|date|null: false|
### Association
- has_many :credits_users
- has_many :credits, through: : credits_users
- has_many :addresses_users
- has_many :addresses, through: : addresses_users
- has_many :products

## productsテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|description|string|null: false|
|brand|string||
|state|string|null: false|
|postage|string|null: false|
|area|string|null: false|
|day|string|null: false|
|price|integer|null: false|
|deal_state|string|null: false|
|user_id|integer|null: false, foreign_key: true|
|category_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :user
- belongs_to :category
- has_many :images

## categoriesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false, unique: true|
|ancestry|string||
### Association
- has_many :products

## imagesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|product_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :product

## creditsテーブル
|Column|Type|Options|
|------|----|-------|
|card_number|string|null: false|
|card_issued|string|null: false|
|card_cvc|string|null: false|
|card_name|string|null: false|
### Association
- has_many :credits_users
- has_many :users, through: :credits_users

## credits_usersテーブル
|Column|Type|Options|
|------|----|-------|
|credit_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :credit
- belongs_to :user

## addressesテーブル
|Column|Type|Options|
|------|----|-------|
|name|string|null: false|
|name_kana|string|null: false|
|postcode|string|null: false|
|prefecture|string|null: false|
|city|string|null: false|
|block|string|null: false|
|building|string||
|phone_number|string||
### Association
- has_many :addresses_users
- has_many :users, through: :addresses_users

## addresses_usersテーブル
|Column|Type|Options|
|------|----|-------|
|address_id|integer|null: false, foreign_key: true|
|user_id|integer|null: false, foreign_key: true|
### Association
- belongs_to :address
- belongs_to :user
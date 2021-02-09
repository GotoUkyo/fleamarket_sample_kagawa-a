class Item < ApplicationRecord
  belongs_to :user
  has_many :images
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :state
  belongs_to_active_hash :postage
  belongs_to_active_hash :day
  belongs_to_active_hash :prefecture
  accepts_nested_attributes_for :images
  with_options presence: true do
    validates :name
    validates :description
    validates :state_id
    validates :postage_id
    validates :prefecture_id
    validates :day_id
    validates :price
  end
end

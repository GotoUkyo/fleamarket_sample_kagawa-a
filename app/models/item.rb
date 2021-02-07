class Item < ApplicationRecord
  belongs_to :user
  has_many :images
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :state
  belongs_to_active_hash :postage
  belongs_to_active_hash :day
  belongs_to_active_hash :prefecture

end

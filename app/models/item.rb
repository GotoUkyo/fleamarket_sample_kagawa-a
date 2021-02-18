class Item < ApplicationRecord
  belongs_to :user
  belongs_to :category
  has_many :images

  def self.search(search)
    if search != ""
      Item.where('name LIKE(?)', "%#{search}%")
    else
      Item.all
    end
  end

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :state
  belongs_to_active_hash :postage
  belongs_to_active_hash :day
  belongs_to_active_hash :prefecture
  accepts_nested_attributes_for :images
  # 複数モデルへの同時保存の際にバリデーションを設定
  validates_associated :images
  with_options presence: true do
    validates :name, length: { maximum: 40}
    validates :description, length: { maximum: 1000}
    validates :state_id
    validates :postage_id
    validates :prefecture_id
    validates :day_id
    validates :price
    validates :images
  end
end

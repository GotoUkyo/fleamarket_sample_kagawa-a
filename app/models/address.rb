class Address < ApplicationRecord
  belongs_to :user, optional: true
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
  with_options presence: true do
    validates :postcode
    validates :prefecture_id
    validates :city
    validates :block
  end
end

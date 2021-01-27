class Address < ApplicationRecord
  belongs_to :user, optional: true
  validates :postcode, :prefecture_id, :city, :block ,presence: true
end

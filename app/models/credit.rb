class Credit < ApplicationRecord
  belongs_to :user, optional: true
  validates :customer_id, presence: true
  validates :card_id, presence: true
end

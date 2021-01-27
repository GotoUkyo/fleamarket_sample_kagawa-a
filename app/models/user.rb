class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  validates :nick_name, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday ,presence: true
  has_one :address
  accepts_nested_attributes_for :address
end

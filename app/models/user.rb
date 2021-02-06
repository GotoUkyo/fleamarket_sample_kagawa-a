class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  with_options presence: true do        
    validates :nick_name, uniqueness:true
    validates :email, format: { with: /\A\S+@\S+\.\S+\z/}
    validates :password, length:{ minimum: 7 }, confirmation: true
    validates :last_name, format: { with: /\A[ぁ-んァ-ン一-龥]/}
    validates :first_name, format: { with: /\A[ぁ-んァ-ン一-龥]/}
    validates :last_name_kana, format: { with: /\A[ァ-ヶー－]+\z/}
    validates :first_name_kana, format: { with: /\A[ァ-ヶー－]+\z/}
    validates :birthday
  end
  has_one :address
  accepts_nested_attributes_for :address
end

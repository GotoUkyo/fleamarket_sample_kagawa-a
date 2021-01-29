class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  # validates :nick_name, :last_name, :first_name, :last_name_kana, :first_name_kana, :birthday, presence: true
  validates :nick_name, presence: true
  validates :email, presence: true, uniqueness:true,
            format: { with: /\A\S+@\S+\.\S+\z/}
  validates :password, presence: true, length:{ minimum: 7 }, confirmation: true
  validates :last_name, presence: true,
            format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,
            message: "全角で入力して下さい"}
  validates :first_name, presence: true,
            format: { with: /\A(?:\p{Hiragana}|\p{Katakana}|[ー－]|[一-龠々])+\z/,
            message: "全角で入力して下さい"}
  validates :last_name_kana, presence: true,
            format: { with: /\A[ァ-ヶー－]+\z/,
            message: "全角カナで入力して下さい"}
  validates :first_name_kana, presence: true,
            format: { with: /\A[ァ-ヶー－]+\z/,
            message: "全角カナで入力して下さい"}
  validates :birthday, presence: true
  has_one :address
  accepts_nested_attributes_for :address
end

class Image < ApplicationRecord
  belongs_to :item

  #画像アップロードのための記載
  mount_uploader :name, ImageUploader
  validates :name, presence: true

end
require 'rails_helper'

describe Image do
  describe '#create' do
    it "画像がなければ登録できない" do
      image = build(:image, name:"")
      image.valid?
      expect(image.errors[:name]).to include("を入力してください")
    end
  end
end
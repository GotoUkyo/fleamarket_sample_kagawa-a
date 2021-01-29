require 'rails_helper'
describe Address do
  describe '#create' do
    it "全ての項目の入力が存在すれば登録できること" do 
      address = FactoryBot.build(:address)
      expect(address).to be_valid
    end

    it "postcodeがない場合は登録できないこと" do
      address = build(:address, postcode: "")
      address.valid?
      expect(address.errors[:postcode]).to include("を入力してください", "は不正な値です")
    end
    it "prefecture_idがない場合は登録できないこと" do
      address = build(:address, prefecture_id: "")
      address.valid?
      expect(address.errors[:prefecture_id]).to include("を入力してください")
    end
    it "cityがない場合は登録できないこと" do
      address = build(:address, city: "")
      address.valid?
      expect(address.errors[:city]).to include("を入力してください")
    end
    it "blockがない場合は登録できないこと" do
      address = build(:address, block: "")
      address.valid?
      expect(address.errors[:block]).to include("を入力してください")
    end
  end
end
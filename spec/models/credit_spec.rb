require 'rails_helper'
describe Credit do
  describe '#create' do
    it "全ての項目の入力が存在すれば購入できること" do 
      credit = build(:credit)
      expect(credit).to be_valid
    end

    it "customer_idがない場合は購入できないこと" do
      credit = build(:credit, customer_id: "")
      credit.valid?
      expect(credit.errors[:customer_id]).to include("を入力してください")
    end

    it "card_idがない場合は購入できないこと" do
      credit = build(:credit, card_id: "")
      credit.valid?
      expect(credit.errors[:card_id]).to include("を入力してください")
    end
  end
end
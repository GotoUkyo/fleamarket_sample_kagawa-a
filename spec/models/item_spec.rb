require 'rails_helper'
  describe Item do
    describe '#create' do
      it "全ての項目の入力が存在すれば登録できること" do
        user = create(:user) 
        item = build(:item,user_id: user.id)
        image = build(:image)
        expect(item).to be_valid
      end

      it "商品名がなければ登録できない" do
        item = build(:item, name: "")
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
      end

      it "商品の説明がなければ登録できない" do
        item = build(:item, description: "")
        item.valid?
        expect(item.errors[:description]).to include("を入力してください")
      end

      it "商品の状態がなければ登録できない" do
        item = build(:item, state_id: "")
        item.valid?
        expect(item.errors[:state_id]).to include("を入力してください")
      end

      it "配送料の負担がなければ登録できない" do
        item = build(:item, postage_id: "")
        item.valid?
        expect(item.errors[:postage_id]).to include("を入力してください")
      end
  
      it "発送元の地域がなければ登録できない" do
        item = build(:item, prefecture_id: "")
        item.valid?
        expect(item.errors[:prefecture_id]).to include("を入力してください")
      end
  
      it "発送までの日数がなければ登録できない" do
        item = build(:item, day_id: "")
        item.valid?
        expect(item.errors[:day_id]).to include("を入力してください")
      end

      it "価格がなければ登録できない" do
        item = build(:item, price: "")
        item.valid?
        expect(item.errors[:price]).to include("を入力してください")
      end
    end
  end

# RSpec.describe Item, type: :model do
#   pending "add some examples to (or delete) #{__FILE__}"
# end

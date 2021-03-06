require 'rails_helper'

  describe Item do
    describe '#create' do
      it "全ての項目（画像も含む）の入力が存在すれば登録できること" do
        item = build(:item)
        expect(item).to be_valid
      end

      it "商品名がなければ登録できない" do
        item = build(:item, name: "")
        item.valid?
        expect(item.errors[:name]).to include("を入力してください")
      end

      it "商品の名前が40文字以上だと登録できない" do
        item = build(:item, name: "a"*41)
        item.valid?
        expect(item.errors[:name]).to include("は40文字以内で入力してください")
      end

      it "商品の説明がなければ登録できない" do
        item = build(:item, description: "")
        item.valid?
        expect(item.errors[:description]).to include("を入力してください")
      end

      it "商品の説明が1000文字以上だと登録できない" do
        item = build(:item, description: "a"*1001)
        item.valid?
        expect(item.errors[:description]).to include("は1000文字以内で入力してください")
      end

      it "商品のブランドがなくても登録できる" do
        user = create(:user) 
        item = build(:item, user_id: user.id, brand:"")
        expect(item).to be_valid
      end

      it "商品のカテゴリーがなければ登録できない" do
        item = build(:item, category_id: "")
        item.valid?
        expect(item.errors[:category_id]).to include("を入力してください")
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

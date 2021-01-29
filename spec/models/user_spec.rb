require 'rails_helper'
describe User do
  describe '#create' do
    it "全ての項目の入力が存在すれば登録できること" do 
      user = build(:user)
      expect(user).to be_valid
    end

    it "nicknameがない場合は登録できないこと" do
      user = build(:user, nick_name: "")
      user.valid?
      expect(user.errors[:nick_name]).to include("を入力してください")
    end

    it "emailがない場合は登録できないこと" do
      user = build(:user, email: "")
      user.valid?
      expect(user.errors[:email]).to include("を入力してください", "は不正な値です")
    end

    it "重複したemailが存在する場合登録できないこと" do
      user1 = create(:user, email: "example@example.com") 
      user2 = build(:user, email: "example@example.com") 
      user2.valid?
      expect(user2.errors[:email]).to include("はすでに存在します")
    end

    it "passwordがない場合は登録できないこと" do
      user = build(:user, password: "")
      user.valid?
      expect(user.errors[:password]).to include("を入力してください", "は7文字以上で入力してください")
    end

    it "passwordが7文字以上であれば登録できること" do
      user = build(:user, password: "1234567", password_confirmation: "1234567")
      user.valid?
      expect(user).to be_valid
    end
 
    it "passwordが6文字以下である場合は登録できないこと" do
      user = build(:user, password: "123456", password_confirmation: "123456")
      user.valid?
      expect(user.errors[:password]).to include("は7文字以上で入力してください")
    end

    it "passwordが存在してもpassword_confirmationが空では登録できないこと" do
      user = build(:user, password_confirmation: "")
      user.valid?
      expect(user.errors[:password_confirmation]).to include("とPasswordの入力が一致しません")
    end

    it "last_nameがない場合は登録できないこと" do
      user = build(:user, last_name: "")
      user.valid?
      expect(user.errors[:last_name]).to include("を入力してください", "は不正な値です")
    end

    it "last_nameが全角でない場合は登録できないこと" do
      user = build(:user, last_name: "ﾔﾏﾓﾄ")
      user.valid?
      expect(user.errors[:last_name]).to include("は不正な値です")
    end

    it "first_nameがない場合は登録できないこと" do
      user = build(:user, first_name: "")
      user.valid?
      expect(user.errors[:first_name]).to include("を入力してください", "は不正な値です")
    end

    it "first_nameが全角でない場合は登録できないこと" do
      user = build(:user, first_name: "ﾀﾞｲｽｹ")
      user.valid?
      expect(user.errors[:first_name]).to include("は不正な値です")
    end

    it "last_name_kanaがない場合は登録できないこと" do
      user = build(:user, last_name_kana: "")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("を入力してください", "は不正な値です")
    end

    it "last_name_kanaが全角でない場合は登録できないこと" do
      user = build(:user, last_name_kana: "ｶﾏｸﾗ")
      user.valid?
      expect(user.errors[:last_name_kana]).to include("は不正な値です")
    end

    it "first_name_kanaがない場合は登録できないこと" do
      user = build(:user, first_name_kana: "")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("を入力してください", "は不正な値です")
    end

    it "first_name_kanaが全角でない場合は登録できないこと" do
      user = build(:user, first_name_kana: "ﾀﾞｲｽｹ")
      user.valid?
      expect(user.errors[:first_name_kana]).to include("は不正な値です")
    end

    it "birthdayがない場合は登録できないこと" do
      user = build(:user, birthday: "")
      user.valid?
      expect(user.errors[:birthday]).to include("を入力してください")
    end
  end
end
class ItemsController < ApplicationController

  before_action :show_all_instance, only: [:edit, :update]     # 商品情報編集機能実装時に追加
  before_action :authenticate_user!, except: [:show, :index ,:search]
  before_action :set_item, only: [:show, :destroy]

  def purchase
    @item = Item.find(params[:id])
    @address = Address.find(current_user.id)
  end

  def show
    @categories = Category.roots
    @category_id = @item.category_id
    @category_parent = Category.find(@category_id).parent.parent
    @category_child = Category.find(@category_id).parent
    @category_grandchild = Category.find(@category_id)
  end

  def new 
    @item = Item.new
    @item.images.build
    # データベースから親カテゴリーのみ抽出し、配列化
    @category_parent = Category.where(ancestry: nil)
  end

  def category_children
    @category_children = Category.find(params[:parent_id]).children
  end

  def category_grandchildren
    @category_grandchildren = Category.find(params[:child_id]).children
  end

  def create
    @item = Item.new(item_params)
    @item.update(deal_state_id: 0)  # 出品ページで値が入力されないdeal_state_idの値をここで代入しておく必要がある
    if @item.valid?
      @item.save
      redirect_to root_path, notice: '商品が投稿されました'
    else
      @category_parent = Category.where(ancestry: nil)
      render :new
    end
  end

  #------------------------
  # editアクション
  # 商品情報の編集
  # 商品情報編集機能実装時に追加
  #------------------------
  def edit
    # ログインユーザが出品した商品かつ未購入状態の商品であればif文に内包された処理を実行
    if @item.user_id == current_user.id and @item.deal_state_id == 0
      # 該当商品の孫・子・親カテゴリーを変数へ代入
      # binding.pryして確認した格納データイメージは下記のとおり
      # 例えば、parentの中身を覗くと・・・
      # => #<Category:0x00007f9121f93620 id: 984, name: "スポーツ・レジャー", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:49 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:49 UTC +00:00>
      grandchild = Category.find(@item.category_id)   # 孫カテゴリーを代入
      child = grandchild.parent                       # 子カテゴリーを代入
      parent = child.parent                           # 親カテゴリーを代入

      # ビューのf.select_collectionの”selected”用
      # 編集画面遷移時にすでに登録されているカテゴリーの情報をセレクトボックスに表示するために利用
      # 親カテゴリーのnameとidを配列へ代入
      # binding.pryして確認した格納データイメージは下記のとおり
      # 例えば、@parent_arrayの中身を覗くと・・・
      # => ["スポーツ・レジャー", 984]
      @parent_array = []                              # 親カテゴリー配列を宣言
      @parent_array << parent.name                    # 親カテゴリー配列に親カテゴリーのnameカラムの値を代入
      @parent_array << parent.id                      # 親カテゴリー配列に親カテゴリーのidカラムの値を代入
      # 子カテゴリーのnameとidを配列代入
      @child_array = []
      @child_array << child.name
      @child_array << child.id
      # 孫カテゴリーのnameとidを配列代入
      @grandchild_array = []
      @grandchild_array << grandchild.name
      @grandchild_array << grandchild.id

      # ビューのf.select_collectionにカテゴリーの一覧を表示するために利用
      # binding.pryして確認した格納データイメージは下記のとおり
      # 例えば、@category_parent_arrayの中身を覗くと・・・
      #=> [#<Category:0x00007f9124d85ab0 id: 1, name: "レディース", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:43 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:43 UTC +00:00>,
        #<Category:0x00007f9124d859e8 id: 200, name: "メンズ", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:44 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:44 UTC +00:00>,
        #<Category:0x00007f9124d85880 id: 346, name: "ベビー・キッズ", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:45 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:45 UTC +00:00>,
        #<Category:0x00007f9124d857b8 id: 481, name: "インテリア・住まい・小物", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:46 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:46 UTC +00:00>,
        #<Category:0x00007f9124d856f0 id: 625, name: "本・音楽・ゲーム", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:47 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:47 UTC +00:00>,
        #<Category:0x00007f9124d85628 id: 685, name: "おもちゃ・ホビー・グッズ", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:47 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:47 UTC +00:00>,
        #<Category:0x00007f9124d85560 id: 798, name: "コスメ・香水・美容", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:48 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:48 UTC +00:00>,
        #<Category:0x00007f9124d85498 id: 898, name: "家電・スマホ・カメラ", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:49 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:49 UTC +00:00>,
        #<Category:0x00007f9124d853d0 id: 984, name: "スポーツ・レジャー", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:49 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:49 UTC +00:00>,
        #<Category:0x00007f9124d85308 id: 1093, name: "ハンドメイド", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:50 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:50 UTC +00:00>,
        #<Category:0x00007f9124d85240 id: 1147, name: "チケット", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:50 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:50 UTC +00:00>,
        #<Category:0x00007f9124d85100 id: 1207, name: "自動車・オートバイ", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:50 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:50 UTC +00:00>,
        #<Category:0x00007f9124d85038 id: 1270, name: "その他", ancestry: nil, created_at: Sun, 14 Feb 2021 07:49:51 UTC +00:00, updated_at: Sun, 14 Feb 2021 07:49:51 UTC +00:00>]
      # 親カテゴリーを全てインスタンス変数へ代入
      @category_parent_array = Category.where(ancestry: nil)
      # 子カテゴリーを全てインスタンス変数へ代入
      @category_children_array = Category.where(ancestry: child.ancestry)
      # 孫カテゴリーを全てインスタンス変数へ代入
      @category_grandchildren_array = Category.where(ancestry: grandchild.ancestry)
    
    # ログインユーザが出品した商品でない場合もしくは商品が購入済みの状態であればelse文に内包された処理を実行
    else
      flash[:alert] = 'すでに購入された商品かあなたが出品者の商品ではないため商品情報の編集はできません。'     # 商品情報を編集できない旨をフラッシュメッセージで表示
      redirect_to item_path                                                                      # 商品詳細ページにリダイレクト
    end
  end

  #-----------------------------
  # updateアクション
  # 商品情報の編集内容をDBに反映させる
  # 商品情報編集機能実装時に追加
  #-----------------------------
  def update
    @item = Item.find(params[:id])                   # 該当商品に紐付けられた商品情報をitemsテーブルから引っ張ってくる
    @item.update(update_params)                      # 商品情報を更新
    flash[:notice] = '商品情報の編集が完了しました。'     # 商品情報を編集できた旨をフラッシュメッセージで表示
    redirect_to item_path                            # 商品情報編集後は商品詳細ページにリダイレクト
  end

  def search
    @items = Item.search(params[:keyword])
  end

  def destroy
    if @item.user_id == current_user.id
       @item.destroy
      redirect_to root_path
    else
      render :show
    end
  end

  # 出品時のデータをDBに送るストロングパラメーター
  private
  def item_params
    params.require(:item).permit(:name,:description,:brand,:state_id,:postage_id,:prefecture_id,:day_id,:price,:category_id, images_attributes: [:name]).merge(user_id: current_user.id)
  end

  # 商品情報編集時用のストロングパラメーター
  def update_params
    params.require(:item).permit(:name,:description,:brand,:state_id,:postage_id,:prefecture_id,:day_id,:price,:category_id, images_attributes: [:name, :id]).merge(user_id: current_user.id)
  end

  def address_params
    params.require(:address).permit(:postcode,:prefecture_id,:city,:block,:building,:phone_number,:user_id).merge(user_id: current_user.id)
  end

  def show_all_instance                                           # 商品情報編集機能実装時に追加
    # インスタンス変数を宣言する順番重要！！
    # @itemを宣言してからでないと、@userなど宣言できずエラーが出る！！
    @item = Item.find(params[:id])                                # 該当商品の情報をインスタンス変数へ代入
    @user = User.find(@item.user_id)                              # 該当商品の出品者情報をインスタンス変数へ代入
    @images = Image.where(item_id: params[:id])                   # 該当商品の画像情報をインスタンス変数へ代入
    #@images_first = Image.where(item_id: params[:id]).first      # 複数枚画像登録の追加実装時に必要かな？

  def set_item
    @item = Item.find(params[:id])
  end
end
class CreditsController < ApplicationController

  require 'payjp' #payjpを使用するために必要な記述

  #-------------------------------------------------------#
  # indexアクション
  # おまじない
  #-------------------------------------------------------#
  def index
    @credit = Credit.new
  end

  #-------------------------------------------------------#
  # newアクション
  # クレジットカード登録情報の有無を確認し、
  # 情報"有"なら登録情報を表示するshowアクションを実行、
  # 情報"無"ならクレジットカード登録画面(new.html.haml)を表示
  #-------------------------------------------------------#
  def new
    credit = Credit.where(user_id: current_user.id).first
    # ↑.where(条件).first：条件（ここではuser_id == current_user.id）にあうテーブル（ここではCredit）の１番目の要素を取得する。
    # 結局のところ、.where(条件).firstはfind_by(条件)と同じ動作？
    redirect_to action: "show" if credit.present?
    # ↑credit.exists?だとエラーになるので注意
    # 参考URL：https://pikawaka.com/rails/exists .whereや.find_byを使って”レコード”の存在チェックをした後にインスタンスを使って何か処理を行う場合は、existsではなくpresetを使う必要があるらしい。
  end

  #-------------------------------------------------------#
  # registerアクション
  # クレジットカード登録情報の有無を確認し、
  # 情報"有"なら登録情報を表示するshowアクションを実行、
  # 情報"無"ならクレジットカード登録画面(new.html.haml)を表示
  #-------------------------------------------------------#
  def register
    # pajpリファレンスの”顧客を作成”に対応
    # 参考URL：https://pay.jp/docs/api/?ruby#%E9%A1%A7%E5%AE%A2%E3%82%92%E4%BD%9C%E6%88%90
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    if params['payjp_token'].blank?
      #payjp_tokenが空なら、creditsコントローラーのnewアクションにリダイレクト
      redirect_to action: "new" # redirect_toの参考URL：https://pikawaka.com/rails/redirect_to
    else
      # payjp_tokenが空でないなら、下記の処理を実行
      # payjpリファレンスの”顧客を作成”に記載されている
      # 参考URL：https://pay.jp/docs/api/?ruby#%E9%A1%A7%E5%AE%A2%E3%82%92%E4%BD%9C%E6%88%90
      # 変数customerを定義
      customer = Payjp::Customer.create(
        email: current_user.email,            #未指定でも良い
        description: 'test',                  #未指定でも良い
        id: 'test',                           #未指定でも良い（未指定の方が無難）
        card: params['payjp_token'],          #これは必須
        metadata: {user_id: current_user.id}  #未指定でも良い
      )
      # creditsテーブルに追加するデータの作成
      @credit = Credit.new(
        user_id: current_user.id,             # ここでcurrent_user.idがいるので、前もってsigninさせておく必要有
        customer_id: customer.id,             # customer.idが未指定の場合、cus_で始まる32桁までの一意な文字列が自動生成される
        card_id: customer.default_card        # .default_cardを使うことで、customer定義時に紐付けされたカード情報を引っ張ってくる
      )
      if @credit.save
        #creditsテーブルへのデータ保存が成功すれば、creditsコントローラーのshowアクションにリダイレクト
        redirect_to action: "show"
      else
        #creditsテーブルへのデータ保存が失敗すれば、creditsコントローラーのnewアクションにリダイレクト
        redirect_to action: "new"
      end
    end
  end

  #-------------------------------------------------------#
  # deleteアクション
  # カード情報を削除する
  #-------------------------------------------------------#
  def delete
    credit = Credit.find_by(user_id: current_user.id)
    if credit.blank?
      # 変数creditsの代入値がblank(=nill)なら何もしない。
    else
      # 変数creditsの代入値がnillでないなら、
      # 処理１：payjpのデータベースを削除
      # リファレンスの”顧客を削除”に対応
      # 参考URL：https://pay.jp/docs/api/?ruby#%E9%A1%A7%E5%AE%A2%E3%81%AE%E3%82%AB%E3%83%BC%E3%83%89%E3%82%92%E5%89%8A%E9%99%A4
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(credit.customer_id)
      customer.delete
      #処理２：creditsテーブルのデータを削除
      credit.delete
      #処理3：トップページにリダイレクトし、フラッシュメッセージで’クレジットカード情報の削除に成功しました’と表示
      flash[:notice] = 'クレジットカード情報の削除に成功しました'
      redirect_to root_path
    end
  end

  #--------------------------------#
  # showアクション
  # カード登録情報を表示する
  #--------------------------------#
  def show
    credit = Credit.find_by(user_id: current_user.id)
    if credit.blank?
      #変数creditsの代入値がblank(=nill)なら、creditsコントローラーのnewアクションにリダイレクト
      redirect_to action: "new" 
    else
      # 変数creditsの代入値がnillでないなら、下記を実行
      # リファレンスの”顧客のカード情報を取得”に対応
      # 参考URL：https://pay.jp/docs/api/?ruby#%E9%A1%A7%E5%AE%A2%E3%81%AE%E3%82%AB%E3%83%BC%E3%83%89%E6%83%85%E5%A0%B1%E3%82%92%E5%8F%96%E5%BE%97
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      customer = Payjp::Customer.retrieve(credit.customer_id)
      @default_card_information = customer.cards.retrieve(credit.card_id)
    end
  end

  #--------------------------------#
  # buyアクション
  # 商品を購入する
  #--------------------------------#
  def buy
    credit = current_user.credit
    @item = Item.find(2) # @item = Item.find(2) # @item = Item.find(params[:id])←最終的にこのコードに書き換えます。
    
    if @item.user_id == current_user.id or @item.deal_state_id == 1
      # 商品出品者のidとログインユーザのidが同じもしくは商品が購入済状態（deal_state_id=1）ならば下記を実行
      # 商品購入確認ページにリダイレクトし、フラッシュメッセージで'購入できません'と表示
      flash[:alert] = '購入できません'
      redirect_to controller: :items, action: :show
    else
      # 商品出品者のidとログインユーザのidが異なってかつ商品が未購入状態（deal_state_id=0）ならば下記を実行
      # 処理１：支払い処理の実行
      # リファレンスの”支払いを作成”に対応
      # 参考URL：https://pay.jp/docs/api/?ruby#%E9%A1%A7%E5%AE%A2%E3%81%AE%E3%82%AB%E3%83%BC%E3%83%89%E6%83%85%E5%A0%B1%E3%82%92%E5%8F%96%E5%BE%97
      Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
      charge = Payjp::Charge.create(
        amount: @item.price,              # amountとcurrencyの組み合わせの代わりにproductというのを指定しても良いらしい
        currency: 'jpy',                  # 3文字のISOコード(現状 “jpy” のみサポート)
        customer: credit.customer_id,     # customer,cardのどちらかは必須でcustomerを使って、cardを未指定の場合はデフォルトカードとして登録されているものが利用される
        description: 'test',              # 未指定でも良い
        capture: true                     # 支払い処理を確定するかどうか。falseの場合、カードの認証と支払い額の確保のみ行う未指定だとtrue扱いのよう。
        # その他、expiry_days（認証状態が失効するまでの日数）やmetadata（キーバリューの任意データ）、
        # PAY.JP Platformというので使えるplatform_feeやtenantがあるが未指定でも問題ないようなので割愛
      )
      # 処理２：商品購入に成功した証としてdeal_state_idの値を0から1に更新
      @item.update(deal_state_id: 1)
      # 処理３：トップページにリダイレクトし、フラッシュメッセージで’購入完了’と表示
      flash[:notice] = '購入完了'
      redirect_to root_path
    end
  end

  private

  def item_params
    params.require(:item).permit(
      :name,
      :description,
      :brand,
      :state_id,
      :postage_id,
      :prefecture_id,
      :day_id,
      :price,
      :deal_state_id,
      :user_id,
      :category_id
    ).merge(user_id: current_user.id)
  end
end
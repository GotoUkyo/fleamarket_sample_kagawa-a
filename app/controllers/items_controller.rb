class ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]

  def index
    @categories = Category.roots
  end

  def show
    @item = Item.find(params[:id]) # @item = Item.find(2) # @item = Item.find(params[:id])←最終的にこのコードに書き換えます。
    @address = Address.find(current_user.id)
  end

  def new 
    @item = Item.new
    @item.images.build
    # データベースから親カテゴリーのみ抽出し、配列化
    @category_parent = Category.where(ancestry: nil)
  end

  def category_children
    @category_children = Category.find(params[:category_id]).children
  end
  def category_grandchildren
    @category_grandchildren = Category.find(params[:category_id]).children
  end

  def create
    @item = Item.new(item_params)
    @item.update(deal_state_id: 0)  # 出品ページで値が入力されないdeal_state_idの値をここで代入しておく必要がある
    if @item.valid?
      @item.save
      redirect_to root_path, notice: '商品が投稿されました'
    else
      render :new
    end
  end
  # 出品時のデータをDBに送るストロングパラメーター
  private
  def item_params
    params.require(:item).permit(:name,:description,:brand,:state_id,:postage_id,:prefecture_id,:day_id,:price,:category_id, images_attributes: [:name]).merge(user_id: current_user.id)
  end

  private

  def address_params
    params.require(:address).permit(
      :postcode,
      :prefecture_id,
      :city,
      :block,
      :building,
      :phone_number,
      :user_id,
    ).merge(user_id: current_user.id)
  end

end
class ItemsController < ApplicationController

  before_action :authenticate_user!, except: [:show, :index]

  def index
  end

  def show
    @item = Item.find(params[:id]) # @item = Item.find(2) # @item = Item.find(params[:id])←最終的にこのコードに書き換えます。
    @address = Address.find(current_user.id)
  end

  def new
    @item = Item.new
    @item.images.build
  end

  def create
    @item = Item.new(item_params)
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
    params.require(:item).permit(:name,:description,:brand,:state_id,:postage_id,:prefecture_id,:day_id,:price,:category, images_attributes: [:name]).merge(user_id: current_user.id)
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
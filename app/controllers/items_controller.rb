class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  def index
    @categories = Category.roots
  end

  def show
  end

  def new 
    # データベースから親カテゴリーのみ抽出し、配列化
    @category_parent = Category.where(ancestry: nil)
  end

  def category_children
    @category_children = Category.find(params[:category_id]).children
  end
  def category_grandchildren
    @category_grandchildren = Category.find(params[:category_id]).children
    
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
  
end
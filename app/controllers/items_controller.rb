class ItemsController < ApplicationController
  def index
    @categories = Category.roots
  end

  def show
  end

  def new
    # @item = Item.new
    
    # データベースから親カテゴリーのみ抽出し、配列化
    @category_parent = Category.where(ancestry: nil)
  end

  def category_children
    @category_children = Category.find(params[:category_id]).children
  end
  def category_grandchildren
    @category_grandchildren = Category.find(params[:category_id]).children
  end
end
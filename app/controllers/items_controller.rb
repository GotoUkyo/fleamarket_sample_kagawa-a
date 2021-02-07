class ItemsController < ApplicationController
  def index
    @categories = Category.roots
  end

  def show
  end

  def new
    @item = Item.new
    # セレクトボックスの初期値設定
    @category_parent_array = ["選択してください"]
    # データベースから親カテゴリーのみ抽出し、配列化
    @category_parent_array = Category.where(ancestry: nil)
  end

  def get_category_children # 親カテゴリーが選択されると子カテゴリーを取得する
    @category_children = Category.find(params[:category_id]).children
  end

  def get_catrgory_grandchildren # 子カテゴリーが選択されると孫カテゴリーを取得する
    @catrgory_grandchildren = Category.find(params[:child_id]).children
  end
end
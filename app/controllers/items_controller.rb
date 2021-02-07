class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @item = Item.new
    # @item.users << current_user
  end

  def create
    @item = Item.new(item_params)
    # binding.pry
    if @item.save
      redirect_to root_path, notice: 'グループを作成しました'
    else
      render :new
    end
  end
  
  private
  def item_params
    params.require(:item).permit(:name,:description,:brand,:state_id,:postage_id,:prefecture_id,:day_id,:price,:category).merge(user_id: current_user.id)
  end
end
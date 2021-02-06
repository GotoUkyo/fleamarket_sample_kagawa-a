class ItemsController < ApplicationController
  def index
  end

  def show
  end

  def new
    @item = Item.new
  end

  def create
    Item.create(item_params)
  end
  
  private
  def item_params
    params.reqire(:item).permit(:name,:description,:brand,:state_id,:postage_id,:area_id,:day_id,:price)
  end
end
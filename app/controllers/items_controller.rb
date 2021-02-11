class ItemsController < ApplicationController

  def index
  end

  def show
    @item = Item.find(2) # @item = Item.find(params[:id])←最終的にこのコードに書き換えます。
    @address = Address.find(current_user.id)
  end

  def new
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
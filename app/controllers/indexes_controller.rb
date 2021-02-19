class IndexesController < ApplicationController

  def index
    @items = Item.includes(:images).order("created_at DESC").limit(10)
  end

  # def show
  # end

end
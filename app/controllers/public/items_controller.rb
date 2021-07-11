class Public::ItemsController < ApplicationController

  def top
    @items = Item.all.page(params[:page]).reverse_order
    @amount = Item.count
    @genres = Genre.where(is_active: true)
  end

  def index
    @items = Item.all.page(params[:page]).reverse_order
    @amount = Item.count
    @genres = Genre.where(is_active: true)
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
    @cart_item = CartItem.new
  end

end
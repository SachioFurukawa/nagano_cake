class Public::CartItemsController < ApplicationController
  before_action :authenticate_user!

  def index
    @cart_items = current_user.cart_items
  end

  def update
    @cart_items = CartItem.find(params[:id])
    if @cart_items.update(cart_item_params)
      redirect_to cart_items_path,success: '個数を変更しました'
    else
      render :index, danger: "個数の変更に失敗しました。"
    end
  end

  def destroy
     @cart_items = CartItem.find(params[:id])
    if @cart_items.destroy
    redirect_to cart_items_path,success: '商品の削除が完了しました。'
    else
      render :index, danger: "商品の削除が出来ませんでした"
    end
  end

  def destroy_all
    user = User.find(current_user.id)
    if user.cart_items.destroy_all
      redirect_to cart_items_path,success: 'カート内の商品を全て削除しました。'
    else
      render :index, danger: "カート内の商品を削除出来ませんでした。"
    end
  end

  def create
    @cart_item = CartItem.new(cart_item_params)
    #binding.pry
    @cart_item.user_id = current_user.id
   if @cart_item.save
     redirect_to cart_items_path,success: '商品をカートに追加しました'
   else
     @item = Item.find(@cart_item.item_id)
     render 'public/items/show'
   end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:amount, :item_id, :name, :price)
  end

end
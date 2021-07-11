class AdminOther::ItemsController < ApplicationController

  def index
    @items = Item.page(params[:page]).reverse_order
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_other_item_path(@item.id), success: "登録完了"
    else
      render action: :new, danger: '登録失敗'
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_other_item_path(@item.id)
    else
      render :edit
    end
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end


  private

  def item_params
    params.require(:item).permit(:name, :image, :introduction, :price, :genre_id, :is_active)
  end

end
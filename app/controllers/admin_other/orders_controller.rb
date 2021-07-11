class AdminOther::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
   path = Rails.application.routes.recognize_path(request.referer)
     if path[:controller] == "admin_other/users" && path[:action] == "show"
       @orders = Order.where(user_id: path[:id])
     else
       @orders = Order.all
     end
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @tax = 1.1
  end

  def update
    #byebug
    @order = Order.find(params[:id])
    if @order.update( order_params )
      #@order.auto_update_status
      redirect_to "/admin_other/orders/#{@order.id}", success: "注文ステータスの更新が完了しました。"
    else
      @order_details = @order.order_details
      render action: :show, danger: "注文ステータスの更新に失敗しました。"
    end
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end

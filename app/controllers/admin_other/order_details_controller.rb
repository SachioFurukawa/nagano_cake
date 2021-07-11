class AdminOther::OrderDetailsController < ApplicationController

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    if @order_detail.update( order_detail_params )
      #byebug
      redirect_to "/admin_other/orders/#{@order.id}", success: "製作ステータスの更新が完了しました。"
    else
      render action: :show, danger: "製作ステータスの更新に失敗しました。"
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

  def order_params
    params.require(:order).permit(:status)
  end

end

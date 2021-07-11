class Public::OrdersController < ApplicationController
  before_action :authenticate_user!

  def new
    @order = Order.new
  end

  def confirm
    # 前提:支払い方法,新規の住所に限り@orderに代入可能
    # if文？
    # ラジオボタンのパラメタを確認→条件分岐→自分または選択済み住所を再代入(れい:@order.postal_code = current_user.postal_code)
    @order = Order.new
    @cart_items = current_user.cart_items
    @postage = 500
    @tax = 1.1

    if params[:order][:payment_method]

      case params[:order][:radio_button_number].to_i
        when 1 ##自分の住所
          address_when1
          @order.payment_method = params[:order][:payment_method].to_i
        when 2 ##登録された住所から選択
          ############
          if !params[:order][:address].present? && params[:order][:radio_button_number] == "2"
            puts "OK"
            render :new, notice: '配送先が選択されていません'and return
          end
          address = Address.find(params[:order][:address])
          @order = Order.new(
          user_id: current_user.id,
          name: address.name,
          postal_code: address.postal_code,
          address: address.address,
          total_charge: @cart_items.map{ |cp| (cp.item.price*cp.amount * @tax) }.sum.round + @postage
          )
          @order.payment_method = params[:order][:payment_method].to_i
          ############
        when 3 ##新しいお届け先
          address_when3
          @order.payment_method = params[:order][:payment_method].to_i
      end
      #redirect_to confirm_orders_path
    else
      @order = Order.new
      @order.user_id = current_user.id
      #render action: :new, notice: '入力されていない項目があります'
    end

    if @order.valid?
    else
      render action: :new, notice: '入力されていない項目があります'
    end

  end


  def create
    #byebug
    @order = Order.new(order_params)
    @order.status = "入金待ち"
    if @order.save
    #if @order = Order.create(order_params)
        @cart_items = CartItem.where(user_id: current_user.id)
          @cart_items.each do |cart_item|
            @order_details = OrderDetail.create(
              item_id: cart_item.item.id,
              order_id: @order.id,
              price: cart_item.item.price,
              amount: cart_item.amount
              )
          end
          @cart_items.destroy_all
          case params[:order][:radio_button_number].to_i
            when 1 #自分の住所
            when 2 #登録された住所から選択
            when 3 #新規作成の住所

              @address = Address.create(
                user_id: current_user.id,
                name: params[:order][:name],
                postal_code: params[:order][:postal_code],
                address: params[:order][:address]
                )
          end
        redirect_to complete_orders_path, success: '購入成功しました.'
    else
        @cart_items = current_user.cart_items
        @postage = 500
        @tax = 1.1
        render :confirm, notice: '購入に失敗しました'
    end
  end

  def complete
  end

  def index
    @order = Order.where(user_id: current_user.id).order(created_at: "DESC").page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
  end



  private

  def address_when1
    ##自分の住所
    @order = Order.new(
    user_id: current_user.id,
    name: current_user.family_name + current_user.first_name,
    postal_code: current_user.postal_code,
    address: current_user.address,
    total_charge: @cart_items.map{ |cp| (cp.item.price*cp.amount * @tax) }.sum.round + @postage
    )
  end

  #def address_when2
    ##登録された住所から選択
    #address = Address.find(params[:order][:address_id])
    #@order = Order.new(
      #user_id: current_user.id,
      #name: address.name,
      #postal_code: address.postal_code,
      #address: address.address,
      #total_charge: @cart_items.map{ |cp| (cp.item.price*cp.amount * @tax) }.sum.round + @postage
    #)
  #end

  def address_when3
    ##新規作成の住所
    @order = Order.new(
    user_id: current_user.id,
    name: params[:order][:name],
    postal_code: params[:order][:postal_code],
    address: params[:order][:address],
    radio_button_number: params[:order][:radio_button_number].to_i,
    total_charge: @cart_items.map{ |cp| (cp.item.price*cp.amount * @tax) }.sum.round + @postage
    )
  end

  def order_params
      params.require(:order).permit(
        :user_id, :name, :postal_code, :address, :payment_method, :postage, :total_charge, :radio_button_number
        )
  end

  #def params_int(model_params)
    #model_params.each do |key, value|
      #if integer_string?(value)
        #model_params[key]=value.to_i
      #end
    #end
  #end

end
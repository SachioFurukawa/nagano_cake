class AdminOther::UsersController < ApplicationController

  def top
     path = Rails.application.routes.recognize_path(request.referer)
     if path[:controller] == "admin_other/users" && path[:action] == "show"
       @orders = Order.where(user_id: path[:id])
     else
       @orders = Order.all
     end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def index
    @users = User.all.page(params[:page]).reverse_order
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_other_user_path(@user.id)
    else
      render action: :edit
    end
  end

  private
  def user_params
    params.require(:user).permit(:user_id, :is_deleted, :first_name, :family_name, :kana_first_name, :kana_family_name, :postal_code, :address, :phone_number, :email)
  end

end

class Public::UsersController < ApplicationController
  before_action :authenticate_user!

  def new
    @user = User.new
  end

  def index
    @user = current_user
  end

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      #binding.pry
     flash[:success] = "会員情報を更新しました"
     redirect_to users_path
    else
      render :edit
    end
  end

  def unsubscribe
    #@user = User.find_by(email: params[:email])
    @user = current_user
    #@user.update(is_deleted: true)
    #reset_session
        #flash[:notice] = "ありがとうございました。またのご利用を心よりお待ちしております。"
        #redirect_to root_path
  end

  def withdraw
    @user = current_user
    #@user = User.find_by(email: params[:email])
    @user.update(is_deleted: false)
    reset_session
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :family_name, :email, :kana_first_name, :kana_family_name, :postal_code, :address, :phone_number)
  end

end

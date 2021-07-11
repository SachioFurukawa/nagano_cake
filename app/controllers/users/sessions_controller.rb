# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  ###before_action :reject_inactive_user, only: [:create]
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
  def create
    user = User.find_by(email: sign_in_params[:email])
    if user.is_deleted == false
      redirect_to root_path, danger: "退会済みのユーザーです。"
    else
      super
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  ###def reject_inactive_user
    ###@user = User.find_by(name: params[:user][:name])
    ###if @user
      ###if @user.valid_password?(params[:user][:password]) && !@user.is_deleted
        ###redirect_to new_user_session_path
      ###end
    ###end
  ###end

end

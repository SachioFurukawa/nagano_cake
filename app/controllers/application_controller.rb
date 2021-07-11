class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up, keys: [
        :first_name,:family_name,:kana_first_name,:kana_family_name,:postal_code,:address,:phone_number,:email
        ]
        )
  end

  def after_sign_in_path_for(resource)
    case resource
    when User
      root_path
    when Admin
      admin_other_path
    end
  end

  def after_sign_out_path_for(resource)
    case resource
    when :user
      root_path
    when :admin
      new_admin_session_path
    end
  end


end

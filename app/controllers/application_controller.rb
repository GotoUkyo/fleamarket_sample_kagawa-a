class ApplicationController < ActionController::Base
  
  # basic認証関連
  before_action :basic_auth, if: :production?
  # サインアップ
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?
  # basic認証関連↓
  private

  def production?
    Rails.env.production?
  end

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :last_name, :first_name, :last_name_kane, :first_name_kana, :birthday])
  end

  # basic認証関連↑

end
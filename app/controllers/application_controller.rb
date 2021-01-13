class ApplicationController < ActionController::Base
  
  # basic認証関連
  before_action :basic_auth, if: :production?

  # basic認証関連↓
  private

  def basic_auth
    authenticate_or_request_with_http_basic do |username, password|
      username == Rails.application.credentials[:basic_auth][:user] &&
      password == Rails.application.credentials[:basic_auth][:pass]
    end
  end

  def production?
    Rails.env.production?
  end
  # basic認証関連↑

end
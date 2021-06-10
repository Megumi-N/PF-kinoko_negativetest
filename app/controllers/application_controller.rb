class ApplicationController < ActionController::Base  
  before_action :user_params

  rescue_from Exception, with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404 
  
  rescue_from Twitter::Error::NotFound, with: :not_found
  rescue_from Twitter::Error::Unauthorized, with: :unauthorized

  
  def render_404
    render template: 'errors/error_404', status: 404
  end

  def render_500
    render template: 'errors/error_500', status: 500
  end

  def unauthorized
    flash[:danger] = "非公開アカウントです。公開アカウントを入力してください。"
    redirect_back(fallback_location: root_path)
  end

  def not_found
    flash[:danger] = "有効なアカウントを入力してください。"
    redirect_back(fallback_location: root_path)
  end  

  
  private

  def user_params
    @user = params[:user]
  end
  
  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key           = Rails.application.credentials.twitter[:api_key]
      config.consumer_secret        = Rails.application.credentials.twitter[:api_secret_key]
      config.access_token           = Rails.application.credentials.twitter[:access_token]
      config.access_token_secret    = Rails.application.credentials.twitter[:access_token_secret]
    end
  end  
end

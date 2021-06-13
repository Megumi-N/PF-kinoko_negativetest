class ApplicationController < ActionController::Base  
  
  # rescue_from Exception, with: :render_500
  # rescue_from ActionController::RoutingError, with: :render_404 
  
  rescue_from Twitter::Error::NotFound, with: :not_found
  rescue_from Twitter::Error::Unauthorized, with: :unauthorized

  
  # def render_404
  #   render template: 'errors/error_404', status: 404
  # end

  # def render_500(e)
  #   logger.error "error_500: #{e.message}"
  #   logger.error e.backtrace.join("\n")
  #   render template: 'errors/error_500', status: 500
  # end

  def unauthorized
    flash[:danger] = "非公開アカウントです。公開アカウントを入力してください。"
    redirect_back(fallback_location: root_path)
  end

  def not_found
    flash[:danger] = "有効なアカウントを入力してください。"
    redirect_back(fallback_location: root_path)
  end  
end

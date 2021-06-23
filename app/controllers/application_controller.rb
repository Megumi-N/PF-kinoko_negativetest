class ApplicationController < ActionController::Base

  rescue_from Exception, with: :render_500
  rescue_from ActionController::RoutingError, with: :render_404

  rescue_from Twitter::Error::NotFound, with: :not_found
  rescue_from Twitter::Error::Unauthorized, with: :unauthorized
  rescue_from Twitter::Error::TooManyRequests, with: :too_many_requests

  def render_500(e)
    logger.error "error_500: #{e.message}"
    logger.error e.backtrace.join("\n")
    render template: 'errors/error_500', status: 500
  end

  def render_404
    render template: 'errors/error_404', status: 404
  end

  def not_found
    flash[:danger] = "有効なアカウントを入力してね。"
    redirect_back(fallback_location: root_path)
  end

  def unauthorized
    flash[:danger] = "非公開アカウントだよ。公開アカウントを入力してね。"
    redirect_back(fallback_location: root_path)
  end

  def too_many_requests
    render template: 'errors/error_429', status: 429
  end
end

class ApplicationController < ActionController::API
  # Required for Devise
  include ActionController::StrongParameters
  include ActionController::MimeResponds

  # Run all reqeusts through CORS filter
  before_action :cors

  # Concerns
  include TokenAuthentication

  # Overwrite 404
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end

  # Overwrite routing error handler
  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

  # Set appropriate headers for CORS requests
  def cors
    headers["Access-Control-Allow-Origin"] = "*"
    headers['Access-Control-Request-Method'] = "*"
    headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE OPTIONS}.join(",")
    headers["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-Tent-Id X-CSRF-Token}.join(",")
    if request.method == 'OPTIONS'
      head(:ok)
    end
  end

  # Render errors in JSON
  rescue_from Exception do |e|
    error(e)
  end

  protected

    def error(e)
      error_info = {
        :error => "internal-server-error",
        :exception => "#{e.class.name} : #{e.message}",
      }
      error_info[:trace] = e.backtrace[0,10] if Rails.env.development?
      render :json => error_info.to_json, :status => 500
    end
end

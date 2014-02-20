class ApplicationController < ActionController::API
  before_action :cors

  def cors
    if request.method == 'OPTIONS'
      headers["Access-Control-Allow-Origin"] = "*"
      headers['Access-Control-Request-Method'] = "*"
      headers["Access-Control-Allow-Methods"] = %w{GET POST PUT DELETE OPTIONS}.join(",")
      headers["Access-Control-Allow-Headers"] = %w{Origin Accept Content-Type X-Requested-With X-CSRF-Token}.join(",")
      head(:ok)
    end
  end

  def routing_error
    raise ActionController::RoutingError.new(params[:path])
  end

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

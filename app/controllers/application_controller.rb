class ApplicationController < ActionController::API
  before_action :ensure_json_request

  def ensure_json_request
    return if request.headers["Accept"] =~ /json/
    render :nothing => true, :status =>406
  end

  private

  def authenticate
    hmac_secret = "secretkey"

    begin
      JWT.decode request.authorization.split(' ').last, hmac_secret, true, {:algorithm => "HS256"}
    rescue => e
      render json: {"error": "Não autorizado!" }
    end
    # ActiveSupport::SecurityUtils.secure_compare(
    #   ::Digest::SHA256.hexdigest(token),
    #   ::Digest::SHA256.hexdigest(token)
    # )

  end
end

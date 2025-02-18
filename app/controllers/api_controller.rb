class ApiController < ActionController::API
  include ActionController::HttpAuthentication::Token::ControllerMethods
  respond_to :json

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user

  private

  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  def authenticate_user
    if request.headers['Authorization'].present?
      authenticate_or_request_with_http_token do |token|
        begin
          jwt_payload = JWT.decode(token, ENV["SECRET_KEY_BASE"]).first
          @current_user_id = jwt_payload['id']
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          head :unauthorized
        end
      end
    end
  end

  def currently_viewing_user
    if request.headers['Authorization'].present?
      authenticate_or_request_with_http_token do |token|
        begin
          jwt_payload = JWT.decode(token, ENV["SECRET_KEY_BASE"]).first
          @current_user_id = jwt_payload['id']
          return true
        rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
          return nil
        end
      end
    end
    return nil
  end

  def authenticate_coach
    head :unathorized unless current_user.is_coach?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end
end
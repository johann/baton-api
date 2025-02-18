class ApplicationController < ActionController::Base
  include ActionController::HttpAuthentication::Token::ControllerMethods
  include ActionController::RequestForgeryProtection
  protect_from_forgery with: :exception, unless: -> { request.format.json? }
  respond_to :json, :html
  # before_action :underscore_params!
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user
  include ActionView::Layouts

  private

  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  def authenticate_user
    # when you're coming from react web this should not exist 
    # but when coming from app it should exist
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

  # Configure params for user sign up eg full name
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:full_name])
  end

  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  def signed_in?
    @current_user_id.present?
  end

  # def underscore_params!
  #   params.deep_transform_keys!(&:underscore)
  # end
end

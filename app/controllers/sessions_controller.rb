class SessionsController < Devise::SessionsController
  def create
    user = User.find_by_email(sign_in_params[:email])
    render json: { errors: "user not found" }, status: :unprocessable_entity unless user

    if user && user.valid_password?(sign_in_params[:password])
      @current_user = user
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end
end
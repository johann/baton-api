class PasswordsController < ApiController
  skip_before_action :authenticate_user, only: :reset

  def forgot
    if params[:email].blank?
      return render json: {error: 'Email not present'}
    end

    user = User.find_by(email: params[:email].downcase)

    if user.present?
      user.generate_password_token!
      Users::CreateForgotPassword.call(code: user.reset_password_token).tap do |c|
        raise c.error if c.failure?
        ForgotPasswordMailer.send_forgot_password_email(user, c.short_link).deliver
      end
      render json: {status: 'ok'}, status: :ok
    else
    end
  end


  def reset
    token = params[:token].to_s

    if params[:token].blank?
      return render json: {error: 'Token not present'}
    end

    if params[:email].blank? || params[:password].blank?
      return render json: {error: 'Email or password not present'}
    end

    user = User.find_by(reset_password_token: token)

    if user.present? && user.password_token_valid?
      if user.reset_password!(params[:password])
        render json: {status: 'ok'}, status: :ok
      else
        render json: {error: user.errors.full_messages}, status: :unprocessable_entity
      end
    else
      render json: {error:  ['Link not valid or expired. Try generating a new link.']}, status: :not_found
    end
  end
end

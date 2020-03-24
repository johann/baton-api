class UsersController < ApiController
  before_action :authenticate_user!

  def show
  end

  def update
    if current_user.update_attributes(user_params)
      if params[:user][:photo].present?
        current_user.photo.attach(data: params[:user][:photo])
      end
      render :show
    else
      render json: { errors: current_user.errors }, status: :unprocessable_entity
    end
  end

  def facebook

  end

  def username
    @user = User.find_by(username: params[:username])
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :image, :coach, :full_name)
  end
end
class UsersController < ApiController
  before_action :authenticate_user!, except: [:facebook]
  skip_before_action :authenticate_user, only: [:facebook]

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
    user = User.find_by(email: params[:email])
    if user
      @user = user
    else
      Users::CreateFacebookUser.call(facebook_params).tap do |c|
        raise c.error if c.failure?
        @user = c.user
      end
    end
  end

  def username
    @user = User.find_by(username: params[:username])
    render :show
  end

  private

  def facebook_params
    params.require(:user).permit(:id, :name, :email, picture: [data: [:height, :width, :url, :is_silhouette]])
  end

  def user_params
    params.require(:user).permit(:username, :email, :password, :bio, :image, :coach, :full_name)
  end
end


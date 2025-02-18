class UsersController < ApiController
  before_action :authenticate_user!, except: [:facebook]
  skip_before_action :authenticate_user, only: [:facebook]

  def show
  end

  def update
    if current_user.update_attributes(user_params)
      if params[:user][:photo].present?
        data = params[:user][:photo]
        UploadPhoto.call(filename: "users/#{current_user.id}", data: data).tap do |c|
          raise c.error if c.failure?
          current_user.update(photo_attached: true)
        end
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

  # TODO: Remove
  def username
    @user = User.find(params[:user_id])
  end

  private

  def facebook_params
    params.require(:user).permit(:id, :name, :email, picture: [data: [:height, :width, :url, :is_silhouette]])
  end

  def user_params
    params.require(:user).permit(:email, :password, :bio, :image, :coach, :full_name, :persona)
  end
end


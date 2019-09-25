class Users::ActivitiesController < ApiController
  before_action :set_user

  def index
    @activities = @user.activities
  end

  private def set_user
    @user = User.find_by(username: params[:username])
  end
end
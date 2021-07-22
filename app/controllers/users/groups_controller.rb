class Users::GroupsController < ApiController
  before_action :set_user

  def index
    @groups = @user.user_groups
  end

  private def set_user
    @user = User.find(params[:id])
  end
end
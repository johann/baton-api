class GroupsController < ApiController
  before_action :set_group, only: [:show, :members]

  def index
    @groups = Group.all
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      render :show, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def show
  end

  def members
    @users = @group.users
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :lat, :long, :photo_url, :user_id, profile_picture)
  end
end

class GroupsController < ApiController
  before_action :set_group, only: [:show, :update]

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

  def update
    if @group.update_attributes(group_params)
      render :show
    else
      render json: { errors: @group.errors }, status: :unprocessable_entity
    end
  end

  def show
  end

  def members
    @group = Group.find(params[:group_id])
    @users = @group.users
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :lat, :long, :photo_url, :user_id, :photo)
  end
end

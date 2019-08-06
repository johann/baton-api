class GroupsController < ApiController
  before_action :set_group, only: [:show]

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

  private 

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :lat, :long, :photo_url, :user_id)
  end
end

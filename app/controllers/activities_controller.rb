class ActivitiesController < ApiController
  before_action :set_activity, only: [:show, :update, :destroy]
  before_action :authenticate_coach, only: [:create, :update, :destroy]

  def index
    @activities = Activity.where(group_id: params[:group_id])
  end
  
  def create
    @activity = Activity.new(activity_params)
    @activity.group_id = params[:group_id]
    if @activity.save
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  def show
  end

  def update
    if @activity.update(activity_params)
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end 

  def destroy
    @activity.destroy
  end

  private 

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:title, :description, :lat, :long, :photo_url, :additional_info, :group_id)
  end
end

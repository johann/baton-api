class ActivitiesController < ApiController
  before_action :set_activity, only: [:show, :update, :destroy]
  before_action :authenticate_coach, only: [:create, :update, :destroy]

  def index
    if params[:scope] == "past"
      @activities = Activity.where(group_id: params[:group_id], start_date: 3.months.ago..1.day.ago)
    elsif params[:scope] == "upcoming"
      @activities = Activity.where(group_id: params[:group_id], start_date: Date.today..3.months.from_now)
    else
      @activities = Activity.where(group_id: params[:group_id])
    end
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.group_id = params[:group_id]
    if @activity.save
      if params[:photo]
        @activity.profile_picture.attach(params[:photo])
      end
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
    params.require(:activity).permit(:title, :description, :lat, :long, :location, :photo_url, :additional_info, :start_date, :end_date, :group_id)
  end
end

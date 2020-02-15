class ActivitiesController < ApiController
  before_action :set_activity, only: [:show, :update, :destroy]
  before_action :authenticate_coach, only: [:create, :update, :destroy]

  def index
    if params[:scope] == "past"
      @activities = Activity.where(group_id: params[:group_id], start_date: 6.months.ago..1.day.ago)
    elsif params[:scope] == "upcoming"
      @activities = Activity.where(group_id: params[:group_id], start_date: Date.today..6.months.from_now)
    else
      @activities = Activity.where(group_id: params[:group_id])
    end
  end

  def discover
    user_activities = current_user.activities.map(&:id)
    coach_activities = current_user.coach_groups.map {|group| group.activities }.flatten.map(&:id)
    activities = user_activities + coach_activities
    @activities = Activity.where.not(id: activities).where(start_date: Date.today..12.months.from_now)
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.group_id = params[:group_id]
    if @activity.save
      if params[:activity][:photo].present?
        @activity.photo.attach(data: params[:activity][:photo])
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
      if params[:activity][:photo].present?
        @activity.photo.attach(data: params[:activity][:photo])
      end
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
    params.require(:activity).permit(:title, :description, :lat, :long, :location, :additional_info, :start_date, :end_date, :group_id, :distance)
  end
end

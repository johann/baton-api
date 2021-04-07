class ActivitiesController < ApiController
  before_action :set_activity, only: [:show, :update, :destroy, :members]
  before_action :authenticate_coach, only: [:create, :update, :destroy]
  before_action :set_currently_viewing_user, only: [:show]
  skip_before_action :authenticate_user, only: [:show]

  def index
    if params[:scope] == "past"
      @activities = Activity.where(group_id: params[:group_id], start_date: 12.months.ago..1.day.ago).limit(20).sort_by(&:start_date)
    elsif params[:scope] == "future"
      @activities = Activity.where(group_id: params[:group_id], start_date: Date.today..12.months.from_now).order(:start_date)
    else
      @activities = Activity.where(group_id: params[:group_id])
    end
  end

  def discover
    user_activities = current_user.activities.map(&:id)
    coach_activities = current_user.coach_groups.map {|group| group.activities }.flatten.map(&:id)
    activities = user_activities + coach_activities
    @activities = Activity.where.not(id: activities).where(start_date: Date.today..12.months.from_now).order(:start_date)
  end

  def create
    @activity = Activity.new(activity_params)
    @activity.group_id = params[:group_id]
    if @activity.save
      CreateLink.call(activity: @activity).tap do |c|
        raise c.error if c.failure?
      end
      if params[:activity][:photo].present?
        data = params[:activity][:photo]
        UploadPhoto.call(filename: "activities/#{@activity.id}", data: data).tap do |c|
          raise c.error if c.failure?
          @activity.update(photo_attached: true)
        end
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
        data = params[:activity][:photo]
        UploadPhoto.call(filename: "activities/#{@activity.id}", data: data).tap do |c|
          raise c.error if c.failure?
          @activity.update(photo_attached: true)
        end
      end
      Activities::NotifyUsers.call(activity: @activity, updated: true).tap do |c|
        raise c.error if c.failure?
      end
      render json: @activity
    else
      render json: @activity.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @activity.destroy
    Activities::NotifyUsers.call(activity: @activity, cancelled: true).tap do |c|
      raise c.error if c.failure?
    end
  end

  def members
    @members = @activity.users
  end

  def search
    query = params[:q]
    @activities = Activity.search_activity(query).where(start_date: Date.today..12.months.from_now).order(:start_date)
  end

  private

  def set_currently_viewing_user
    @currently_viewing_user = currently_viewing_user
  end

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:title, :description, :lat, :long, :location, :additional_info, :start_date, :end_date, :group_id, :distance)
  end
end

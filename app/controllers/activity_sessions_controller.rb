class ActivitySessionsController < ApiController
  before_action :set_activity_session, only: [:show, :update, :destroy]
  before_action :authenticate_coach, only: [:create, :update, :destroy]

  def index
    @activity_sessions = Activity.where(group_id: params[:group_id]).map {|activity| activity.activity_sessions }
  end

  def show
  end

  def create
    @activity_session = ActivitySession.new(activity_session_params)
    if @activity_session.save
      render json: @activity_session
    else
      render json: @activity_session.errors, status: :unprocessable_entity
    end
  end

  def update
    if @activity_session.update(activity_session_params)
      render json: @activity_session
    else
      render json: @activity_session.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @activity.destroy
  end

  def set_activity_session
    @activity_session = ActivitySession.find(params[:id])
  end

  def activity_session_params
    params.require(:activity_session).permit(:time)
  end
end

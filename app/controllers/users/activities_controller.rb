class Users::ActivitiesController < ApiController
  before_action :set_user

  def index
    if params[:scope] == "past"
      @activities = @user.activities.where(start_date: 12.months.ago..1.day.ago).order(:start_date).sort_by(&:start_date)
    elsif params[:scope] == "future"
      @activities = @user.activities.where(start_date: Date.today..12.months.from_now).order(:start_date)
    else
      @activities = @user.activities
    end
  end

  private def set_user
    @user = User.find(params[:id])
  end
end
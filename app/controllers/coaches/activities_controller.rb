class Coaches::ActivitiesController < ApiController
  def index
    begin
      @user = User.find(params[:coach_id])
      head :not_found unless @user.is_coach?
      if params[:scope] == "past"
        @activities = @user.coach_activities.where(start_date: 12.months.ago..1.day.ago).order(:start_date).sort_by(&:start_date)
      elsif params[:scope] == "future"
        @activities = @user.coach_activities..where(start_date: Date.today..12.months.from_now).order(:start_date)
      else
        @activities = @user.coach_activities
      end
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end
end
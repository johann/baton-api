class Coaches::ActivitiesController < ApiController
  def index
    begin
      @user = User.find(params[:coach_id])
      head :not_found unless @user.is_coach?
      if params[:scope] == "past"
        @activities = Activity.where(coach_id: @user.id, start_date: 12.months.ago..1.day.ago).order(:start_date).sort_by(&:start_date)
      elsif params[:scope] == "future"
        @activities = Activity.where(coach_id: @user.id, start_date: Date.today..12.months.from_now).order(:start_date)
      else
        @activities = Activity.where(coach_id: @user.id)
      end
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end
end
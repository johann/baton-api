class Coaches::ActivitiesController < ApiController
  def index
    begin
      @user = User.find(params[:coach_id])
      head :not_found unless @user.is_coach?
      
      @groups = @user.coach_groups
      @activities = @groups.flat_map do |group|
        if params[:scope] == "past"
          group.activities.where(start_date: 12.months.ago..1.day.ago).order(:start_date).sort_by(&:start_date)
        elsif params[:scope] == "future"
          group.activities.where(start_date: Date.today..12.months.from_now).order(:start_date)
        else
          group.activities
        end
      end
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end
end
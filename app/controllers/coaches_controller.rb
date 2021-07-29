class CoachesController < ApiController
  # before_action :set_group, only: [:show, :update]

  def index
    current_user_groups = current_user.user_groups
    groups_without_current_user = Group.all.reject do |group|
      current_user_groups.include?(group) || group.head_coach == current_user
    end
    @coaches = groups_without_current_user.map { |group| group.head_coach }
  end

  def discover
    user_activities = current_user.activities.map(&:id)
    coach_activities = current_user.coach_groups.map {|group| group.activities }.flatten.map(&:id)
    activities = user_activities + coach_activities
    @activities = Activity.where.not(id: activities).where(start_date: Date.today..5.days.from_now).order(:start_date)
    @coaches = @activities.map { |a| a.group.head_coach }.uniq
  end

  def show
    begin
      @user = User.find(params[:id])
      head :not_found unless @user.is_coach?
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end
end

class CoachesController < ApiController
  # before_action :set_group, only: [:show, :update]

  def index
    current_user_groups = current_user.groups
    groups_without_current_user = Group.all.reject do |group|
      current_user_groups.include?(group) || group.coach == current_user
    end
    @coaches = groups_without_current_user.map { |group| group.coach }
  end

  def show
    begin
      @user = User.find(params[:id])
      head :not_found unless @user.coach?
    rescue ActiveRecord::RecordNotFound
      head :not_found
    end
  end
end

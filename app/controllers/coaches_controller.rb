class CoachesController < ApiController
  # before_action :set_group, only: [:show, :update]

  def index
    @coaches = User.where(coach: true)
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

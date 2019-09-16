class Coach::GroupsController < ApiController
  before_action :authenticate_coach, only: [:index]

  def index
    @groups = current_user.coach_groups
  end
end
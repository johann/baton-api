class User::GroupsController < ApiController
  def index
    @groups = current_user.groups
  end

  def create
    @membership = Membership.new(user_id: current_user.id, group_id: params[:group_id])
    if @membership.save
      head :ok
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @membership = Membership.find_by(user_id: current_user.id, group_id: params[:id])
    @membership.destroy
  end
end
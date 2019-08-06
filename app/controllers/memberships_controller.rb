class MembershipsController < ApiController
  before_action :set_membership, only: [:show, :delete]
  def index
    @memberships = Memberships.find_by(user_id: current_user.id)
  end

  def create
    @membership = Membership.new(membership_params)
    if @membership.save
      render :show, status: :created, location: @membership
    else
      render json: @membership.errors, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy
    @membership.destroy
  end

  def set_membership
    @membership = Memebrship.find(params[:id])
  end

  def membership_params
    params.require(:membership).permit(:group_id, :user_id)
  end
end

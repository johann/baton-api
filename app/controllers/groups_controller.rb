class GroupsController < ApiController
  before_action :set_group, only: [:show, :update]

  def index
    @groups = Group.all
  end

  def create
    @group = Group.new(group_params)
    if @group.save
      if params[:group][:photo].present?
        data = params[:group][:photo]
        @group.photo = @group.photo_url
        @group.save
        UploadPhoto.call(filename: "groups/#{@group.id}", data: data).tap do |c|
          raise c.error if c.failure?
          @group.update(photo_attached: true)
        end
      end
      render :show, status: :created, location: @group
    else
      render json: @group.errors, status: :unprocessable_entity
    end
  end

  def update
    if @group.update_attributes(group_params)
      if params[:group][:photo].present?
        data = params[:group][:photo]
        UploadPhoto.call(filename: "groups/#{@group.id}", data: data).tap do |c|
          raise c.error if c.failure?
          @group.update(photo_attached: true)
        end
      end
      render :show
    else
      render json: { errors: @group.errors }, status: :unprocessable_entity
    end
  end

  def show
  end

  def members
    @group = Group.find(params[:group_id])
    @users = @group.members
  end

  def discover
    user_groups = current_user.user_groups.map(&:id) + current_user.coach_groups.map(&:id)

    @groups = Group.where.not(id: user_groups.uniq)
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :lat, :long, :location)
  end
end

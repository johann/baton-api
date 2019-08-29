class User::ActivitiesController < ApiController
  def index
    @activities = current_user.activities
  end

  def create
    @attendance = Attendance.new(user_id: current_user.id, activity_id: params[:activity_id])
    if @attendance.save
      render json: @attendance, status: :created
    else 
      render json: @attendance.errors, status: :unprocessable_entity
    end 
  end

  def destroy
    @attendance = Attendance.find_by(user_id: current_user.id, activity_id: params[:id])
    @attendance.destroy
  end
end
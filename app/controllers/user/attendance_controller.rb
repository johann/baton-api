class User::AttendanceController < ApiController do
  def create
    @attendance = Attendance.new(user_id: current_user.id, activity_session_id: params[:activity_session_id])
    if @attendance.save
      head :ok
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @attendance = Attendance.find_by(user_id: current_user.id, activity_session_id: params[:activity_session_id]))
    @attendance.destroy
  end
end
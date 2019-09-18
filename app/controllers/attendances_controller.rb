class AttendancesController < ApplicationController
  before_action :group, :set_activity

  def show
    @users = @activity.users.filter { |u| u.id != current_user }
  end

  private

  def group
    @group ||= Group.find(params[:group_id])
  end

  def set_activity
    @activity = group.activities.find(params[:activity_id])
  end
end

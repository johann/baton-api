class Share::ActivitiesController < ApplicationController
  skip_before_action :authenticate_user

  def show
    @activity = Activity.find(params[:id])
  end

end
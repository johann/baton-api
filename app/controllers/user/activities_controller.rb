class User::ActivitiesController < ApiController do
  def index
    @activities = current_user.activities_sessions.map {|activity_session| activity_session.activity }
  end
end
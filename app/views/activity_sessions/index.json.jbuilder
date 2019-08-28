json.array! @activity_sessions do |activity_session|
  json.partial! 'activity_sessions/activity_session', locals: { activity_session: activity_session }
end
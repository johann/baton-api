json.array! @activities do |activity|
  json.partial! 'activities/activity', locals: { activity: activity }
end
json.array! @activity do |activity|
  json.partial! 'activities/activity', locals: { activity: activity }
end
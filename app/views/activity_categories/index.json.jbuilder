json.array! @activity_categories do |activity_category|
  json.partial! 'activity_categories/activity_category', locals: { activity_category: activity_category }
end
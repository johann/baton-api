json.array! @activity_categories do |activity_category|
  json.partial! 'coach/activity_categories/activity_category', locals: { activity_category: activity_category }
end
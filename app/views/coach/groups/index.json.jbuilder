json.array! @groups do |group|
  json.partial! 'groups/group', locals: { group: group }
end
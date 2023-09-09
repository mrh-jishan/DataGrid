json.array! @csv_headers do |header|
  json.title header[:name].downcase.gsub(" ", "_")
  json.field header[:name]
  json.aggregate_function header[:aggregate_function]
  json.width 150 # we may later change this in db level
end

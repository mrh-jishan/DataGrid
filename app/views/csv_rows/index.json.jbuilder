# json.array! @csv_headers do |header|
#   json.title header[:name].downcase.gsub(" ", "_")
#   json.field header[:name]
#   json.width 150 # we may later change this in db level
# end

json.array! @rows
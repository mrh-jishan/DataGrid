json.columns do
  json.array! @csv_headers do |header|
    json.title header[:name] #.downcase.gsub(" ", "_")
    json.field header[:name]
    json.width 150
  end
  json.array! [{ name: 'Unique By' }] do |header|
    json.title header[:name]
    json.field header[:name]
    json.width 150
    # json.formatter "array"
  end
end

json.last_page @pagy.last

json.data do
  json.array! @csv_rows do |csv_row|
    json.set! :id, csv_row[:id]
    json.set! :'Unique By', csv_row[:unique_by]
    json.merge! csv_row[:csv_row]
    # json.id csv_row['id']
    # json.file_upload_id csv_row['file_upload_id']
    # json.created_at csv_row['created_at']
    # json.updated_at csv_row['updated_at']
  end
end

# json.headers @csv_headers
# json.file_upload @file_upload
json.pagy @pagy
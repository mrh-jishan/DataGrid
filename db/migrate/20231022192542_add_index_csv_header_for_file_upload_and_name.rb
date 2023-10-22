class AddIndexCsvHeaderForFileUploadAndName < ActiveRecord::Migration[7.0]
  def change
    add_index :csv_headers, [:name, :file_upload_id], :unique => true
  end
end

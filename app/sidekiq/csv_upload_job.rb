require 'csv'

class CsvUploadJob
  include Sidekiq::Job

  def perform(csv_file_id)
    file_upload = FileUpload.find(csv_file_id)

    CSV.foreach(file_upload.file.path, headers: true) do |row|
      csv_row_data = row.to_h

      csv_row_data.keys.each do |header_name|
        CsvHeader.find_or_create_by(name: header_name, file_upload: file_upload)
      end

      CsvRow.upsert({ csv_row: csv_row_data, file_upload_id: file_upload.id }, :unique_by => [:csv_row, :file_upload_id])
    end

  end

end

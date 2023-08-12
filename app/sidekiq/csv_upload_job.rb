require 'csv'

class CsvUploadJob
  include Sidekiq::Job

  def perform(csv_file_id)
    file_upload = FileUpload.find(csv_file_id)

    CSV.foreach(file_upload.file.path, headers: true) do |row|
      csv_row_data = row.to_h

      csv_row_data.keys.each do |header_name|

        cell_value = csv_row_data[header_name]
        data_type = infer_data_type(cell_value)

        CsvHeader.find_or_create_by(name: header_name, data_type: data_type, file_upload: file_upload)
      end

      CsvRow.upsert({ csv_row: csv_row_data, file_upload_id: file_upload.id }, :unique_by => [:csv_row, :file_upload_id])
    end

  end

  def infer_data_type(value)
    case value
    when /\A\d+\z/ # Matches integers
      :integer
    when /\A\d+\.\d+\z/ # Matches decimals/floats
      :float
    when /\A\d{4}-\d{2}-\d{2}\z/ # Matches dates in yyyy-mm-dd format
      :date
    else
      :string # Default to string data type if the type cannot be determined
    end
  end

end

require 'csv'

class CsvUploadJob
  include Sidekiq::Job

  def perform(csv_file_id)
    file_upload = FileUpload.find(csv_file_id)

    data = CSV.read(file_upload.file.path, headers: true)

    first_row = data.first
    csv_header_data = data.headers.map { |header| { name: header, file_upload_id: file_upload.id, aggregate_function: infer_aggregate_function(first_row[header]) } }
    CsvHeader.upsert_all(csv_header_data, :unique_by => [:name, :file_upload_id])

    csv_row_data = data.map { |row| { csv_row: row.to_h,
                                      file_upload_id: file_upload.id,
                                      unique_by: uniq_column_value(file_upload.unique_by, row) } }

    CsvRow.upsert_all(csv_row_data, :unique_by => [:csv_row, :file_upload_id])
  end

  def infer_aggregate_function(value)
    case value
    when /\A\d+\z/ # Matches integers
      :sum
    when /\A\d+\.\d+\z/ # Matches decimals/floats
      :sum
    when /\A\d{4}-\d{2}-\d{2}\z/ # Matches dates in yyyy-mm-dd format
      :count
    else
      :count # Default to string data type if the type cannot be determined
    end
  end

  def uniq_column_value(columns, row)
    columns.compact.reject(&:empty?).map { |column| row[column] }
  end

end

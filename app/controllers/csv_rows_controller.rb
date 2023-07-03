class CsvRowsController < ApplicationController

  before_action :set_file_upload, :only => [:index]

  def index
    @rows = @file_upload.csv_rows.select("csv_row->>'Order ID' AS email, csv_row->>'Category' AS city, csv_row->>'Currency' AS company")
    .group("company, email, city")

    # @file_upload.csv_rows.select("jsonb_data->>'Order ID' AS email, jsonb_data->>'Category' AS city, jsonb_data->>'Currency' AS company")
    #         .from("csv_rows, jsonb_array_elements(csv_rows.csv_row) AS jsonb_data")
    #         .group("company, email, city")

    puts "@rows: #{@rows.inspect}"

    # result = CsvRow.select("jsonb_data->>'Email' AS email, jsonb_data->>'City' AS city, jsonb_data->>'Company' AS company")
    #                .from("csv_rows, jsonb_array_elements(csv_rows.data) AS jsonb_data")
    #                .group("company, email, city")

  end

  def set_file_upload
    @file_upload = FileUpload.find(params[:file_upload_id])
  end

end

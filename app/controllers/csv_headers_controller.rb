class CsvHeadersController < ApplicationController

  def index
    @file_upload = FileUpload.find(params[:file_upload_id])
    @csv_headers = @file_upload.csv_headers
  end

end

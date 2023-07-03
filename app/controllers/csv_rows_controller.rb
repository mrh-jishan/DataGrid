class CsvRowsController < ApplicationController

  before_action :set_file_upload, :only => [:index]

  def index
    @rows = @file_upload.csv_rows
  end

  def set_file_upload
    @file_upload = FileUpload.find(params[:file_upload_id])
  end

end

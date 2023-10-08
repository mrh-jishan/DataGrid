class DashboardsController < ApplicationController

  before_action :set_file_upload, :only => [:index]

  def index
    @csv_headers = @file_upload.csv_headers
    @rows = @file_upload.csv_rows
  end

  def set_file_upload
    @file_upload = current_user.file_uploads.find(params[:file_upload_id])
  end

end

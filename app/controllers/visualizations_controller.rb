class VisualizationsController < ApplicationController

  before_action :set_file_upload, :only => [:create, :show]

  def create
    @visualization = @file_upload.visualizations.new(chart_type: "bar")
    respond_to do |format|
      if @file_upload.save
        format.html { redirect_to file_upload_visualization_path(@file_upload, @visualization) }
      else
        format.html { redirect_to @file_upload }
      end
    end
  end

  def show
    @csv_headers = @file_upload.csv_headers
    @rows = @file_upload.csv_rows
  end

  protected

  def set_file_upload
    @file_upload = FileUpload.find(params[:file_upload_id])
  end

end

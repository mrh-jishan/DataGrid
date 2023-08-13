class CsvHeadersController < ApplicationController

  before_action :set_csv_headers, :only => [:index, :update_data_type]

  def index
  end

  def update_data_type
    @csv_header = @csv_headers.find(params[:id])
    respond_to do |format|
      if @csv_header.update(csv_header_params)
        format.json { render json: @csv_header, status: :ok }
      else
        format.json { render json: { success: false, errors: @csv_header.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  protected

  def set_csv_headers
    @file_upload = FileUpload.find(params[:file_upload_id])
    @csv_headers = @file_upload.csv_headers
  end

  def csv_header_params
    params.require(:csv_header).permit(:data_type)
  end

end

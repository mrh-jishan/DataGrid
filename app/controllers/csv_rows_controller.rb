class CsvRowsController < ApplicationController

  before_action :set_file_upload, :only => [:index, :update]

  def index
    column_names = JSON.parse(URI.decode_www_form_component(params[:column_names].to_s))
    group_by = JSON.parse(URI.decode_www_form_component(params[:group_by].to_s))
    @rows = @file_upload.csv_rows.select_columns(column_names).group_by_column_names(group_by)
  end

  def update
    @csv_row = @file_upload.csv_rows.find(params[:id])
    respond_to do |format|
      if @csv_row.update(file_upload_params)
        format.json { render json: { success: true } }
      else
        format.json { render json: { success: false, errors: @file_upload.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  protected

  def set_file_upload
    @file_upload = current_user.file_uploads.find(params[:file_upload_id])
  end

end

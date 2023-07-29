class CsvRowsController < ApplicationController

  before_action :set_file_upload, :only => [:index]

  def index

    puts "column_name---------#{params[:column_names]}"
    puts "group_by---------#{params[:group_by]}"
    column_names = params[:column_names]&.split(',') || []
    group_by = params[:group_by]&.split(',') || []
    @rows = @file_upload.csv_rows.select_columns(column_names).select(:id)
    # .group_by_columns(column_names)
  end

  def set_file_upload
    @file_upload = FileUpload.find(params[:file_upload_id])
  end

end

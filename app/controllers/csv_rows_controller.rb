class CsvRowsController < ApplicationController

  before_action :set_file_upload, :only => [:index]

  def index
    column_names = JSON.parse(URI.decode_www_form_component(params[:column_names].to_s))
    group_by = JSON.parse(URI.decode_www_form_component(params[:group_by].to_s))

    puts "column_names--------------#{column_names}"
    puts "group_by--------------#{group_by}"

    @rows = @file_upload.csv_rows.select_columns(column_names).group_by_column_names(group_by)
  end

  protected

  def set_file_upload
    @file_upload = current_user.file_uploads.find(params[:file_upload_id])
  end

end

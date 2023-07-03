class CsvRowsController < ApplicationController

  before_action :set_file_upload, :only => [:index]

  def index
    # @rows = @file_upload.csv_rows.select("csv_row->>'Order ID' AS order_id, csv_row->>'Category' AS category, csv_row->>'Currency' AS currency")
    #                     .group("order_id, category, currency")
    column_names = ['Order ID', 'Category', 'Currency']
    @rows = @file_upload.csv_rows.select_columns(column_names).group_by_columns(column_names)
  end

  def set_file_upload
    @file_upload = FileUpload.find(params[:file_upload_id])
  end

end

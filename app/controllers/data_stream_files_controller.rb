class DataStreamFilesController < ApplicationController
  before_action :set_data_stream
  before_action :set_data_stream_file, :only => [:destroy, :import_again]

  def index
    @data_stream_files = @data_stream.data_stream_files
  end

  def destroy
    @data_stream_file.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@data_stream_file) }
    end
  end

  def import_again
    @file_upload = current_user.file_uploads.new(file: @data_stream_file.file, import_source: :data_stream, :unique_by => {})
    if @file_upload.save
      CsvUploadJob.perform_async(@file_upload.id)
      redirect_to data_stream_data_stream_files_path(@data_stream), notice: 'Data stream was submitted successfully.'
    else
      redirect_to data_stream_data_stream_files_path(@data_stream), alert: "Data stream was submission unsuccessfully. #{@file_upload.errors.full_messages}"
    end
  end

  private

  def set_data_stream_file
    @data_stream_file = @data_stream.data_stream_files.find(params[:id])
  end

  def set_data_stream
    @data_stream = current_user.data_streams.find(params[:data_stream_id])
  end

end

class DataStreamFilesController < ApplicationController
  before_action :set_data_stream
  before_action :set_data_stream_file, :only => [:destroy]

  def index
    @data_stream_files = @data_stream.data_stream_files
  end

  def destroy
    @data_stream_file.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@data_stream_file) }
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

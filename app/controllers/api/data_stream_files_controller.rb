class Api::DataStreamFilesController < ApiController
  before_action :set_data_stream, :only => [:index, :create]

  def index
    render :json => {}
  end

  def create
    render :json => {}
  end

  private

  def set_data_stream
    # @data_stream =
  end
end

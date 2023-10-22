class Api::DataStreamFilesController < ApiController
  before_action :set_data_stream, :only => [:index, :create]

  def index
    render :json => {}
  end

  def create
    gid = data_stream_file_params[:gid]
    data_stream = GlobalID::Locator.locate gid
    data_stream_file = data_stream.data_stream_files.build({ file: data_stream_file_params[:file] })

    if data_stream_file.save
      render :json => data_stream_file, status: :created
    else
      render json: data_stream_file.errors, status: :unprocessable_entity
    end

  end

  private

  def set_data_stream
    # @data_stream =
  end

  private

  def data_stream_file_params
    params.require(:data_stream_file).permit(:file, :gid)
  end

end

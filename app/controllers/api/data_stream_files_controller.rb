class Api::DataStreamFilesController < ApiController
  before_action :set_data_stream, :only => [:index, :create]

  def index
    render :json => {}
  end

  def create
    data_stream = GlobalID::Locator.locate(data_stream_file_params[:gid])

    data_stream_file = data_stream.data_stream_files.build(file: data_stream_file_params[:file])
    return handle_errors(data_stream_file) unless data_stream_file.save

    data_stream.dataset.update(file: data_stream_file.file)

    CsvUploadJob.perform_async(data_stream.dataset_id)
    render json: data_stream_file, status: :created
  end

  private

  def handle_errors(resource)
    render json: resource.errors, status: :unprocessable_entity
  end

  def set_data_stream
    # @data_stream =
  end

  private

  def data_stream_file_params
    params.require(:data_stream_file).permit(:file, :gid)
  end

end

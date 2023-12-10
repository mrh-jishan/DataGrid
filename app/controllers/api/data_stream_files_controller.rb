class Api::DataStreamFilesController < ApiController
  before_action :set_data_stream, :only => [:index, :create]

  def index
    render :json => {}
  end

  def create
    data_stream = GlobalID::Locator.locate(data_stream_file_params[:gid])

    data_stream_file = data_stream.data_stream_files.build(file: data_stream_file_params[:file])
    return handle_errors(data_stream_file) unless data_stream_file.save

    dataset = current_user.datasets.new(file: data_stream_file.file,
                                        import_source: :data_stream,
                                        unique_by: data_stream.unique_by,
                                        name: data_stream_file_params[:dataset_name])
    return handle_errors(dataset) unless dataset.save

    CsvUploadJob.perform_async(dataset.id)
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
    params.require(:data_stream_file).permit(:file, :gid, :dataset_name)
  end

end

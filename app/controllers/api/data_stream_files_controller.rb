class Api::DataStreamFilesController < ApiController
  before_action :set_data_stream, :only => [:index, :create]

  def index
    render :json => {}
  end

  def create
    gid = data_stream_file_params[:gid]
    data_stream = GlobalID::Locator.locate(gid)

    data_stream_file = data_stream.data_stream_files.build(file: data_stream_file_params[:file])
    return handle_errors(data_stream_file) unless data_stream_file.save

    file_upload = current_user.file_uploads.new(file: data_stream_file.file, import_source: :data_stream)
    return handle_errors(file_upload) unless file_upload.save

    CsvUploadJob.perform_async(file_upload.id)
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

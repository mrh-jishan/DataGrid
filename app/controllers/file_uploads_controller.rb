class FileUploadsController < ApplicationController

  def index
    @file_uploads = FileUpload.all
  end

  def new
    @file_upload = FileUpload.new
  end

  def create
    @file_upload = FileUpload.new(file_upload_params)

    if @file_upload.save
      CsvUploadJob.perform_async(@file_upload.id)
      redirect_to file_upload_path(@file_upload), notice: "File was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
    @file_upload = FileUpload.find(params[:id])
  end

  protected

  def file_upload_params
    params.require(:file_upload).permit(:file)
  end

end

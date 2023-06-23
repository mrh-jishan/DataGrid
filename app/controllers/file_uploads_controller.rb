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
    @csv_headers = @file_upload.csv_headers
    @csv_rows = @file_upload.csv_rows
  end

  def edit

  end

  def update
    @file_upload = FileUpload.find(params[:id])
    @csv_row = @file_upload.csv_rows.find(params[:csv_row_id])
    if @csv_row.update(file_upload_params)
      respond_to do |format|
        # format.html { redirect_to @file_upload, notice: 'Item was successfully updated.' }
        format.json { render json: { success: true } }
      end
    else
      respond_to do |format|
        # format.html { render :edit }
        format.json { render json: { success: false, errors: @file_upload.errors.full_messages }, status: :unprocessable_entity }
      end
    end
  end

  protected

  def file_upload_params
    params.require(:file_upload).permit(:file, :City)
  end

end

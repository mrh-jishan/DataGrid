class DatasetsController < ApplicationController
  include Pagy::Backend

  before_action :set_dataset, :only => [:show, :destroy]

  def index
    @datasets = current_user.datasets.order(created_at: :desc)
    @dataset = current_user.datasets.new
  end

  def new
    @datasets = current_user.datasets.order(created_at: :desc)
    @dataset = current_user.datasets.new
  end

  def create
    @dataset = current_user.datasets.new(dataset_params)
    respond_to do |format|
      if @dataset.save
        CsvUploadJob.perform_async(@dataset.id)
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('datasets', partial: 'datasets/dataset', locals: { dataset: @dataset }) }
        format.html { redirect_to dataset_path(@dataset), notice: "Dataset was successfully created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('error-container', partial: 'errors/unprocessable_entity', locals: { exception: @dataset }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @csv_headers = @dataset.csv_headers
    @pagy, @csv_rows = pagy(@dataset.csv_rows)
  end

  def edit

  end

  def destroy
    @dataset.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@dataset) }
    end
  end

  protected

  def set_dataset
    @dataset = current_user.datasets.find(params[:id])
  end

  def dataset_params
    params.require(:dataset).permit(:name, :file, unique_by: [])
  end

end

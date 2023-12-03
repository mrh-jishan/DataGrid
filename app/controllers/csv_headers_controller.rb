class CsvHeadersController < ApplicationController

  before_action :set_csv_headers, :only => [:index, :update]

  def index
  end

  def update
    @csv_header = @csv_headers.find(params[:id])
    respond_to do |format|
      if @csv_header.update(csv_header_params)
        format.turbo_stream
      else
        format.turbo_stream
      end
    end
  end

  protected

  def set_csv_headers
    @dataset = current_user.datasets.find(params[:dataset_id])
    @csv_headers = @dataset.csv_headers
  end

  def csv_header_params
    params.require(:csv_header).permit(:aggregate_function)
  end

end

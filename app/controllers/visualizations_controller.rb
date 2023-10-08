class VisualizationsController < ApplicationController

  before_action :set_file_upload, :only => [:index, :create, :show, :update]
  before_action :set_visualization, :only => [:update, :show]

  def index

  end

  def create
    @visualization = @file_upload.visualizations.new(chart_type: "bar")
    respond_to do |format|
      if @file_upload.save
        format.html { redirect_to file_upload_visualization_path(@file_upload, @visualization) }
      else
        format.html { redirect_to @file_upload }
      end
    end
  end

  def update
    @visualization.patch_aggregators(visualizations_params[:columnNames], visualizations_params[:groupBy])

    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end

  def show
    @x_axis_headers = @file_upload.csv_headers.x_axi_headers.where(aggregators: { visualization: @visualization })
    @y_axis_headers = @file_upload.csv_headers.y_axi_headers.where(aggregators: { visualization: @visualization })
    @csv_headers = @file_upload.csv_headers.where.not(id: @x_axis_headers.ids).where.not(id: @y_axis_headers.pluck(:id))
    @rows = @file_upload.csv_rows

  end

  protected

  def set_visualization
    @visualization = @file_upload.visualizations.find(params[:id])
  end

  def set_file_upload
    @file_upload = FileUpload.find(params[:file_upload_id])
  end

  def visualizations_params
    params.require(:visualizations).permit(:columnNames => {}, :groupBy => {})
  end

end

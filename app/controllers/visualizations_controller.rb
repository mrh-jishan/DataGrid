class VisualizationsController < ApplicationController

  before_action :set_file_upload
  before_action :set_visualization, :only => [:update, :show, :destroy]

  def index
    @visualizations = @file_upload.visualizations
  end

  def new
    @visualization = @file_upload.visualizations.new
  end

  def create
    @visualization = @file_upload.visualizations.new(visualization_params.merge(chart_type: "bar"))

    respond_to do |format|
      if @file_upload.save
        # format.turbo_stream
        format.turbo_stream { render turbo_stream: turbo_stream.redirect(file_upload_visualization_path(@file_upload, @visualization)) }
        format.html { redirect_to file_upload_visualization_path(@file_upload, @visualization) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('error-container', partial: 'errors/unprocessable_entity', locals: { exception: @visualization }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    @visualization.patch_aggregators(visualization_params[:columnNames], visualization_params[:groupBy])

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

  def destroy
    @visualization.destroy
    respond_to do |format|
      format.html { redirect_to file_upload_visualizations_path(@file_upload), notice: 'User was successfully destroyed.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@visualization) }
    end
  end

  protected

  def set_visualization
    @visualization = @file_upload.visualizations.find(params[:id])
  end

  def set_file_upload
    @file_upload = FileUpload.find(params[:file_upload_id])
  end

  def visualization_params
    params.require(:visualization).permit(:label, :columnNames => {}, :groupBy => {})
  end

end

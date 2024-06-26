class VisualizationsController < ApplicationController

  before_action :set_dataset
  before_action :set_visualization, :only => [:update, :show, :destroy]

  def index
    @visualizations = @dataset.visualizations
  end

  def new
    @visualization = @dataset.visualizations.new
  end

  def create
    @visualization = @dataset.visualizations.new(visualization_params)

    respond_to do |format|
      if @visualization.save
        format.turbo_stream { render turbo_stream: turbo_stream.redirect(dataset_visualization_path(@dataset, @visualization)) }
        format.html { redirect_to dataset_visualization_path(@dataset, @visualization) }
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
    @x_axis_headers = @dataset.csv_headers.x_axi_headers.where(aggregators: { visualization: @visualization })
    @y_axis_headers = @dataset.csv_headers.y_axi_headers.where(aggregators: { visualization: @visualization })
    @csv_headers = @dataset.csv_headers.where.not(id: @x_axis_headers.ids).where.not(id: @y_axis_headers.pluck(:id))
    @rows = @dataset.csv_rows
  end

  def destroy
    @visualization.destroy
    respond_to do |format|
      format.html { redirect_to dataset_visualizations_path(@dataset), notice: 'User was successfully destroyed.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@visualization) }
    end
  end

  protected

  def set_visualization
    @visualization = @dataset.visualizations.find(params[:id])
  end

  def set_dataset
    @dataset = current_user.datasets.find(params[:dataset_id])
  end

  def visualization_params
    params.require(:visualization).permit(:label, :chart_type, :columnNames => {}, :groupBy => {})
  end

end

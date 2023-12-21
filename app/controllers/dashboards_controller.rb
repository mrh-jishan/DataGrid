class DashboardsController < ApplicationController

  before_action :set_dashboard, :only => [:show, :destroy]

  def index
    @dashboards = current_user.dashboards
    @visualizations = current_user.visualizations
  end

  def new
    @dashboard = current_user.dashboards.new
  end

  def create
    @dashboard = current_user.dashboards.new(dashboard_params)
    respond_to do |format|
      if @dashboard.save
        format.turbo_stream { render turbo_stream: turbo_stream.redirect(dashboard_path(@dashboard)) }
        format.html { redirect_to dashboard_path(@dashboard) }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('error-container', partial: 'errors/unprocessable_entity', locals: { exception: @dashboard }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show

  end

  def destroy
    @dashboard.destroy
    respond_to do |format|
      format.html { redirect_to dashboards_path, notice: 'Dashboard was successfully destroyed.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@dashboard) }
    end
  end

  protected

  def set_dashboard
    @dashboard = current_user.dashboards.find(params[:id])
  end

  def dashboard_params
    params.require(:dashboard).permit(:label, visualization_ids: [])
  end

end

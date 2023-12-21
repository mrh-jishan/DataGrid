class SharedDashboardsController < ApplicationController
  before_action :set_dashboard

  def index
    @shared_dashboards = @dashboard.shared_dashboards
  end

  def new
    @shared_dashboard = @dashboard.shared_dashboards.new
  end

  def create
    @shared_dashboard = @dashboard.shared_dashboards.new(shared_dashboard_params)
    respond_to do |format|
      if @shared_dashboard.save
        format.turbo_stream { render turbo_stream: turbo_stream.redirect(dashboard_shared_dashboards_path(@dashboard)) }
        format.html { redirect_to dashboard_shared_dashboards_path(@dashboard), notice: "Shared dashboard was successfully created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('error-container', partial: 'errors/unprocessable_entity', locals: { exception: @shared_dashboard }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  protected

  def shared_dashboard_params
    params.require(:shared_dashboard).permit(:expires_at)
  end

  def set_dashboard
    @dashboard = current_user.dashboards.find(params[:dashboard_id])
  end
end

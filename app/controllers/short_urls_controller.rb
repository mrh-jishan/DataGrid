class ShortUrlsController < ApplicationController
  before_action :set_dashboard, :only => [:index, :new, :create]

  def index
    @short_urls = @dashboard.short_urls
  end

  def new
    @short_url = @dashboard.short_urls.new
  end

  def create
    @short_url = @dashboard.short_urls.new(short_url_params)
    respond_to do |format|
      if @short_url.save
        format.turbo_stream { render turbo_stream: turbo_stream.redirect(dashboard_short_urls_path(@dashboard)) }
        format.html { redirect_to dashboard_short_urls_path(@dashboard), notice: "Shared dashboard was successfully created." }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('error-container', partial: 'errors/unprocessable_entity', locals: { exception: @short_url }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def show
    @short_url = ShortUrl.find_by(:slug => ShortCode.decode(params[:slug]))
    @dashboard = @short_url.shareable
    render layout: "shared"
  end

  protected

  def short_url_params
    params.require(:short_url).permit(:expires_at)
  end

  def set_dashboard
    @dashboard = current_user.dashboards.find(params[:dashboard_id])
  end

end

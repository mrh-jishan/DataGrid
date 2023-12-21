class Shared::DashboardsController < SharedController

  def show
    @short_url = ShortUrl.find_by(:slug => ShortCode.decode(params[:id]))
    @dashboard = @short_url.shareable
    render layout: "shared"
  end

end

class DataPlatformsController < ApplicationController

  before_action :set_data_platform, :only => [:destroy, :edit, :update]

  def index
    @data_platforms = current_user.data_platforms.includes([:platform])
  end

  def new
    @platforms = Platform.where.not(:id => current_user.platforms.ids)
    @data_platform = current_user.data_platforms.build
  end

  def create
    @platforms_user = current_user.data_platforms.new(platforms_users_params)
    respond_to do |format|
      if @platforms_user.save
        format.html { redirect_to data_platforms_path, notice: 'Platforms was added successfully.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @data_platform.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@data_platform) }
    end
  end

  def edit
    excluded_ids = current_user.platforms.ids - [@data_platform.platform_id]
    @platforms = Platform.where.not(:id => excluded_ids)
  end

  def update
    respond_to do |format|
      if @data_platform.update(platforms_users_params)
        format.html { redirect_to data_platforms_path, notice: 'Platforms was updated successfully.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  protected

  def platforms_users_params
    params.require(:data_platform).permit(:platform_id, :config)
  end

  def set_data_platform
    @data_platform = current_user.data_platforms.find(params[:id])
  end
end

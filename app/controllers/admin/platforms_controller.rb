class Admin::PlatformsController < ApplicationController

  before_action :set_platform, :only => [:edit, :destroy, :update]

  def index
    @platforms = Platform.all
  end

  def new
    @platform = Platform.new
  end

  def create
    @platform = Platform.new(platforms_params)

    respond_to do |format|
      if @platform.save
        format.html { redirect_to admin_platforms_path, notice: 'Platforms was created successfully.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @platform.destroy
    respond_to do |format|
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@platform) }
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @platform.update(platforms_params)
        format.html { redirect_to admin_platforms_path, notice: 'Platforms was updated successfully.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  private

  def platforms_params
    params.require(:platform).permit(:label)
  end

  def set_platform
    @platform = Platform.find(params[:id])
  end

end

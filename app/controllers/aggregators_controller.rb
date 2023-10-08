class AggregatorsController < ApplicationController
  before_action :set_aggregator, :only => [:destroy]

  def destroy
    @aggregator.destroy
    respond_to do |format|
      format.json { render json: { success: true } }
    end
  end

  protected

  def set_aggregator
    @file_upload = current_user.file_uploads.find(params[:file_upload_id])
    @visualization = @file_upload.visualizations.find(params[:visualization_id])
    @aggregator = @visualization.aggregators.find_by(csv_header_id: params[:id])
  end

end

class DataStreamsController < ApplicationController
  before_action :set_data_stream, :only => [:destroy, :edit, :update]

  def index
    @data_streams = current_user.data_streams
  end

  def new
    @data_stream = current_user.data_streams.new
  end

  def create
    @data_stream = current_user.data_streams.new(data_stream_params)
    respond_to do |format|
      if @data_stream.save
        format.html { redirect_to data_stream_params, notice: 'Data stream was added successfully.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit

  end

  def update
    respond_to do |format|
      if @data_stream.update(data_stream_params)
        format.html { redirect_to data_streams_path, notice: 'Data stream was updated successfully.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @data_stream.destroy
    respond_to do |format|
      format.html { redirect_to data_streams_path, notice: 'Data stream was successfully destroyed.' }
      format.turbo_stream { render turbo_stream: turbo_stream.remove(@data_stream) }
    end
  end

  private

  def data_stream_params
    params.require(:data_stream).permit :label
  end

  def set_data_stream
    @data_stream = current_user.data_streams.find(params[:id])
  end

end

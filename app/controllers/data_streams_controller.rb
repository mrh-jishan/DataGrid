class DataStreamsController < ApplicationController
  before_action :set_data_stream, :only => [:destroy, :edit, :update]

  def index
    @data_streams = current_user.data_streams
  end

  def new
    @datasets = current_user.datasets
    @data_stream = current_user.data_streams.new
  end

  def create
    @data_stream = current_user.data_streams.new(data_stream_params)
    respond_to do |format|
      if @data_stream.save
        format.turbo_stream { render turbo_stream: turbo_stream.prepend('data_streams', partial: 'data_streams/data_stream', locals: { data_stream: @data_stream }) }
        format.html { redirect_to data_stream_data_stream_files_path(@data_stream), notice: 'Data stream was added successfully.' }
      else
        format.turbo_stream { render turbo_stream: turbo_stream.replace('error-container', partial: 'errors/unprocessable_entity', locals: { exception: @data_stream }) }
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @datasets = current_user.datasets
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
    params.require(:data_stream).permit(:dataset_id)
  end

  def set_data_stream
    @data_stream = current_user.data_streams.find(params[:id])
  end

end

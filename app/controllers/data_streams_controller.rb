class DataStreamsController < ApplicationController
  def index
    @data_streams = current_user.data_streams
  end

  def new

  end

  def create

  end

  def destroy

  end

end

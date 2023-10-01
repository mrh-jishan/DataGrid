class HomeController < ApplicationController
  def index
    @file_upload = FileUpload.new
  end

end

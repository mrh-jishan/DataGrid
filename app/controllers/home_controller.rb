class HomeController < ApplicationController
  def index
    @file_upload = FileUpload.new
    @file_uploads = FileUpload.all
  end

end

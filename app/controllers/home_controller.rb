class HomeController < ApplicationController
  def index
    @file_upload = FileUpload.new
    @file_uploads = FileUpload.order(created_at: :desc)
  end

end

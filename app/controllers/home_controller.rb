class HomeController < ApplicationController
  def index
    @file_upload = current_user.file_uploads
    @file_uploads = current_user.file_uploads.order(created_at: :desc)
  end

end

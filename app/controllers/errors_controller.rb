class ErrorsController < ApplicationController
  def internal_server_error
  end

  def not_found
    flash[:alert] = "Access denied: You do not have permission to access this page."
  end

  def bad_request
  end
end

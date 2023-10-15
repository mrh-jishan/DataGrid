# app/controllers/concerns/exception_handler.rb
module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from StandardError, with: :render_error
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActionController::ParameterMissing, with: :bad_request
    # Add more rescue_from statements for other exception types as needed
  end

  private

  def render_error(exception)
    logger.error(exception.message)
    respond_to do |format|
      format.html { render partial: 'errors/internal_server_error', status: :internal_server_error, locals: { exception: exception } }
      format.json { render json: { error: 'Internal Server Error' }, status: :internal_server_error }
      format.turbo_stream { render turbo_stream: turbo_stream.replace('error-container', partial: 'errors/internal_server_error', locals: { exception: exception }) }
    end
  end

  def not_found
    respond_to do |format|
      format.html { render partial: 'errors/not_found', status: :not_found }
      format.json { render json: { error: 'Not Found' }, status: :not_found }
      format.turbo_stream { render turbo_stream: turbo_stream.replace('error-container', partial: 'errors/not_found') }
    end
  end

  def bad_request(exception)
    logger.error(exception.message)
    respond_to do |format|
      # format.html { render 'errors/bad_request', status: :bad_request }
      format.html { render partial: 'errors/bad_request', locals: { exception: exception }, status: :bad_request }
      format.json { render json: { error: exception.message }, status: :bad_request }
      format.turbo_stream { render turbo_stream: turbo_stream.replace('error-container', partial: 'errors/bad_request', locals: { exception: exception }) }
    end
  end

end

class ApiController < ActionController::API

  before_action :validate_auth_token

  def current_user
    @current_user ||= User.find_by(api_token: request.headers['Authorization'])
  end

  private

  def validate_auth_token
    unless current_user&.valid?
      render json: { error: 'Invalid token' }, status: :unauthorized
    end
  end

end

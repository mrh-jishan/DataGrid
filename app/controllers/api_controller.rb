class ApiController < ActionController::API

  before_action :validate_global_id

  private

  def validate_global_id
    global_id = request.headers['X-Global-ID']
    @gid = GlobalID::Locator.locate_signed(global_id)
    unless @gid.present?
      render json: { error: 'Invalid GlobalID' }, status: :unauthorized
    end
  end

end

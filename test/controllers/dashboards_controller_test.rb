require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @file_upload = file_uploads(:one)
  end

  test "should get index" do
    get file_upload_dashboards_url(@file_upload)
    assert_response :success
  end
end

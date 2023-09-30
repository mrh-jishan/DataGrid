require "test_helper"

class CsvRowsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @file_upload = file_uploads(:one)
  end

  test "should get index" do
    get file_upload_csv_rows_url(@file_upload, params: { column_names: '[]', group_by: '[]' })
    assert_response :success
  end
end

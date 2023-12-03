require "test_helper"

class CsvRowsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    sign_in users(:one)
    @dataset = datasets(:one)
  end

  test "should get index" do
    get dataset_csv_rows_url(@dataset, format: :json, params: { column_names: '[]', group_by: '[]' })
    assert_response :success
  end
end

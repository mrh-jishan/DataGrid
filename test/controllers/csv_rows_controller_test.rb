require "test_helper"

class CsvRowsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get csv_rows_index_url
    assert_response :success
  end
end

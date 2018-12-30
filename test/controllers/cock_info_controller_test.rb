require 'test_helper'

class CockInfoControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cock_info_index_url
    assert_response :success
  end

end

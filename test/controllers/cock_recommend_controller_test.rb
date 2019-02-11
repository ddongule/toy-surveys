require 'test_helper'

class CockRecommendControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get cock_recommend_index_url
    assert_response :success
  end

end

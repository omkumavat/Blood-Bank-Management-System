require "test_helper"

class UserDashboardControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get user_dashboard_index_url
    assert_response :success
  end
end

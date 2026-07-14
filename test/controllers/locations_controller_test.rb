require "test_helper"

class LocationsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get locations_index_url
    assert_response :success
  end

  test "should get index with page" do
    get locations_url(page: "1")
    assert_response :success
  end

  test "should redirect from index if page is invalid" do
    get locations_url(page: "999")
    assert_redirected_to locations_url
    assert_equal "Invalid page", flash[:alert]
  end

  test "should get show" do
    get location_url(locations(:location_one))
    assert_response :success
  end
end

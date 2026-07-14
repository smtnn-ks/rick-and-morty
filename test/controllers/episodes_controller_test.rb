require "test_helper"

class EpisodesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get episodes_url
    assert_response :success
  end

  test "should get index with page" do
    get episodes_url(page: "1")
    assert_response :success
  end

  test "should redirect from index if page is invalid" do
    get episodes_url(page: "999")
    assert_redirected_to episodes_url
    assert_equal "Invalid page", flash[:alert]
  end

  test "should get show" do
    get episodes_url
    assert_response :success
  end
end

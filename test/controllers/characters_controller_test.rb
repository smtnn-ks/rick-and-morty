require "test_helper"

class CharactersControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get characters_url
    assert_response :success
  end

  test "should get index with page" do
    get characters_url(page: "1")
    assert_response :success
  end

  test "should redirect from index if page is invalid" do
    get characters_url(page: "999")
    assert_redirected_to characters_url
    assert_equal "Invalid page", flash[:alert]
  end

  test "should get show" do
    get character_url(characters(:character_one))
    assert_response :success
  end
end

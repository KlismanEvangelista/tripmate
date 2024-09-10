require "test_helper"

class TravelsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get travels_index_url
    assert_response :success
  end

  test "should get new" do
    get travels_new_url
    assert_response :success
  end

  test "should get create" do
    get travels_create_url
    assert_response :success
  end

  test "should get my_travels" do
    get travels_my_travels_url
    assert_response :success
  end

  test "should get change_status" do
    get travels_change_status_url
    assert_response :success
  end
end

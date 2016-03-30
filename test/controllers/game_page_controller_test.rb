require 'test_helper'

class GamePageControllerTest < ActionController::TestCase
  test "should get mode" do
    get :mode
    assert_response :success
  end

  test "should get start" do
    get :start
    assert_response :success
  end

end

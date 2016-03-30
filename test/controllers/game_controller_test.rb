require 'test_helper'

class GameControllerTest < ActionController::TestCase
  test "should get begin" do
    get :begin
    assert_response :success
  end

  test "should get next" do
    get :next
    assert_response :success
  end

end

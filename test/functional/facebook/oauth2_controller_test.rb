require 'test_helper'

class Facebook::Oauth2ControllerTest < ActionController::TestCase
  test "should get auth" do
    get :auth
    assert_response :success
  end

  test "should get callback" do
    get :callback
    assert_response :success
  end

end

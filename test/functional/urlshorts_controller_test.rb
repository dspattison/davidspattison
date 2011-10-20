require 'test_helper'

class UrlshortsControllerTest < ActionController::TestCase
  setup do
    @urlshort = urlshorts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:urlshorts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create urlshort" do
    assert_difference('Urlshort.count') do
      post :create, :urlshort => @urlshort.attributes
    end

    assert_redirected_to urlshort_path(assigns(:urlshort))
  end

  test "should show urlshort" do
    get :show, :id => @urlshort.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @urlshort.to_param
    assert_response :success
  end

  test "should update urlshort" do
    put :update, :id => @urlshort.to_param, :urlshort => @urlshort.attributes
    assert_redirected_to urlshort_path(assigns(:urlshort))
  end

  test "should destroy urlshort" do
    assert_difference('Urlshort.count', -1) do
      delete :destroy, :id => @urlshort.to_param
    end

    assert_redirected_to urlshorts_path
  end
end

require 'test_helper'

class Spaste::PastesControllerTest < ActionController::TestCase
  setup do
    @spaste_paste = spaste_pastes(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:spaste_pastes)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create spaste_paste" do
    assert_difference('Spaste::Paste.count') do
      post :create, :spaste_paste => @spaste_paste.attributes
    end

    assert_redirected_to spaste_paste_path(assigns(:spaste_paste))
  end

  test "should show spaste_paste" do
    get :show, :id => @spaste_paste.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @spaste_paste.to_param
    assert_response :success
  end

  test "should update spaste_paste" do
    put :update, :id => @spaste_paste.to_param, :spaste_paste => @spaste_paste.attributes
    assert_redirected_to spaste_paste_path(assigns(:spaste_paste))
  end

  test "should destroy spaste_paste" do
    assert_difference('Spaste::Paste.count', -1) do
      delete :destroy, :id => @spaste_paste.to_param
    end

    assert_redirected_to spaste_pastes_path
  end
end

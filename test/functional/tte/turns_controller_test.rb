require 'test_helper'

class Tte::TurnsControllerTest < ActionController::TestCase
  setup do
    @tte_turn = tte_turns(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:tte_turns)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tte_turn" do
    assert_difference('Tte::Turn.count') do
      post :create, :tte_turn => @tte_turn.attributes
    end

    assert_redirected_to tte_turn_path(assigns(:tte_turn))
  end

  test "should show tte_turn" do
    get :show, :id => @tte_turn.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @tte_turn.to_param
    assert_response :success
  end

  test "should update tte_turn" do
    put :update, :id => @tte_turn.to_param, :tte_turn => @tte_turn.attributes
    assert_redirected_to tte_turn_path(assigns(:tte_turn))
  end

  test "should destroy tte_turn" do
    assert_difference('Tte::Turn.count', -1) do
      delete :destroy, :id => @tte_turn.to_param
    end

    assert_redirected_to tte_turns_path
  end
end

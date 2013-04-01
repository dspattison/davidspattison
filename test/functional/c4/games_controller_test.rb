require 'test_helper'

class C4::GamesControllerTest < ActionController::TestCase
  setup do
    @c4_game = c4_games(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:c4_games)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create c4_game" do
    assert_difference('C4::Game.count') do
      post :create, :c4_game => @c4_game.attributes
    end

    assert_redirected_to c4_game_path(assigns(:c4_game))
  end

  test "should show c4_game" do
    get :show, :id => @c4_game.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @c4_game.to_param
    assert_response :success
  end

  test "should update c4_game" do
    put :update, :id => @c4_game.to_param, :c4_game => @c4_game.attributes
    assert_redirected_to c4_game_path(assigns(:c4_game))
  end

  test "should destroy c4_game" do
    assert_difference('C4::Game.count', -1) do
      delete :destroy, :id => @c4_game.to_param
    end

    assert_redirected_to c4_games_path
  end
end

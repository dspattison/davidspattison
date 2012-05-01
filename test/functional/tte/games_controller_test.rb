require 'test_helper'

class Tte::GamesControllerTest < ActionController::TestCase
  setup do
    @tte_game = tte_games(:one)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create tte_game" do
    assert_difference('Tte::Turn.count') do
      assert_difference('Tte::Game.count') do
        post :create, :tte_game => @tte_game.attributes
      end
    end

    assert_redirected_to tte_game_path(assigns(:tte_game))
  end

  test "should show tte_game" do
    get :show, :id => @tte_game.to_param
    assert_response :success
  end

  test "should get edit" do
    get :edit, :id => @tte_game.to_param
    assert_response :success
  end

  test "should update tte_game" do
    put :update, :id => @tte_game.to_param, :tte_game => @tte_game.attributes
    assert_redirected_to tte_game_path(assigns(:tte_game))
  end

  test "should destroy tte_game" do
    assert_difference('Tte::Game.count', -1) do
      delete :destroy, :id => @tte_game.to_param
    end

    assert_redirected_to tte_games_path
  end
  
  # test "move basic" do
    # assert_difference('Tte::Turn.count') do
      # assert_difference('Tte::Game.count') do
        # post :create, {:square=>0, :tte_game => @tte_game.attributes}
      # end
    # end
# 
    # assert_redirected_to tte_game_path(assigns(:tte_game))
#     
    # assert_difference('Tte::Turn.count') do
      # get :move, {:game_id=>@tte_game.id, :tte_game => {:square=>1, :player=>Tte::Board::TILE_O}}
    # end
# 
  # end
end

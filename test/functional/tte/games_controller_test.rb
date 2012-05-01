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
  
  test "move basic" do
    assert_difference('Tte::Turn.count') do
      assert_difference('Tte::Game.count') do
        post :create, {:square=>0, :tte_game => {:player_a_email=>'a@patt.us', :player_b_email=>'b@patt.us'}}
      end
    end
    
    assert assigns(:tte_game)
    @tte_game = assigns(:tte_game)

    assert_redirected_to tte_game_path(assigns(:tte_game))
    
    def assert_do_move square, player, is_valid=true
      assert_difference('Tte::Turn.count') do
        get :move, {:game_id=>@tte_game.to_param, :tte_game => {:square=>square, :player=>player}}
        assert assigns(:message), "no message!!?"
        if is_valid
          assert 'good' == assigns(:message_class), "message class is not good: #{assigns(:message_class)}"
        else
          assert 'good' != assigns(:message_class), "message class is good: #{assigns(:message_class)}"
        end
      end
    end
    
   assert_do_move 3, Tte::Board::TILE_O
   assert_do_move 1, Tte::Board::TILE_X
   assert_do_move 4, Tte::Board::TILE_O
   #assert_do_move 2, Tte::Board::TILE_X, false
   #assert_do_move 4, Tte::Board::TILE_O, false

  end
end

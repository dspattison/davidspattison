require 'test_helper'

class Tte::GamesControllerTest < ActionController::TestCase
  include Tte::GamesHelper
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
      assert_difference(['Tte::Turn.count', 'ActionMailer::Base.deliveries.count']) do
        get :move, {:game_id=>@tte_game.to_param, :tte_game => {:square=>square, :player=>player}}
        assert assigns(:message), "no message!!?"
        if is_valid
          assert 'good' == assigns(:message_class), "message class is not good: #{assigns(:message_class)} #{assigns().inspect}"
        else
          assert 'good' != assigns(:message_class), "message class is good: #{assigns(:message_class)}  #{assigns().inspect}"
        end
      end
    end
    
   assert_do_move 3, Tte::Board::TILE_O
   assert_do_move 1, Tte::Board::TILE_X
   assert_do_move 4, Tte::Board::TILE_O
   
   #we have a winner!
   assert_difference 'Tte::Turn.count' do
     assert_difference 'ActionMailer::Base.deliveries.count', 2 do
       get :move, {
         :game_id=>@tte_game.to_param, 
         :tte_game => {:square=>2, :player=>Tte::Board::TILE_X}}
     end
   end
   assert assigns(:message).include?('Won'), "no winner!? #{assigns.inspect}"
   #assert_do_move 4, Tte::Board::TILE_O, false

  end
  
  test "tieing move" do
    #just create a full board
    @tte_game = Tte::Game.new
    @tte_game.save!
    @tte_turn = Tte::Turn.new({:board=> 43350, :game_id=>@tte_game.id, :number=>1})
    @tte_turn.save!
    
    assert_difference 'Tte::Turn.count' do
      assert_difference 'ActionMailer::Base.deliveries.count', 2 do
        get :move, {
          :game_id=>@tte_game.to_param, 
          :tte_game => {:square=>8, :player=>Tte::Board::TILE_X}}
        #raise Exception.new(Tte::Turn.all.inspect)
      end
    end
    
    assert assigns(:message).include?('Tie'), "no tie!? #{assigns.inspect}"

  end
  
  test "should restart game" do
    
    #just create a full board
    @tte_game = Tte::Game.new({:player_a_email=>'a@patt.us', :player_b_email=>'b@patt.us'})
    @tte_game.save!
    @tte_turn = Tte::Turn.new({:board=> 43350, :game_id=>@tte_game.id, :number=>1})
    @tte_turn.save!
    
    
    assert_difference 'Tte::Turn.count' do
      assert_difference 'ActionMailer::Base.deliveries.count', 1 do
        get :restart, {
          :game_id=>@tte_game.to_param, 
          :tte_game => {
            :square=>8, 
            :current_player_email=>@tte_game.player_a_email,
            :sig=>get_email_hash(@tte_game.player_a_email),
          }
        }
        #raise Exception.new(Tte::Turn.all.inspect)
      end
    end
    
  end
  
  test "restart should complain about bad email" do
    @tte_game = Tte::Game.new({:player_a_email=>'a@patt.us', :player_b_email=>'b@patt.us'})
    @tte_game.save!
    @tte_turn = Tte::Turn.new({:board=> 43350, :game_id=>@tte_game.id, :number=>1})
    @tte_turn.save!
    
    assert_difference 'Tte::Turn.count', 0 do
      assert_difference 'ActionMailer::Base.deliveries.count', 0 do 
        get :restart, {
          :game_id=>@tte_game.to_param, 
          :tte_game => {
            :square=>8, 
            :current_player_email=>'not the correct email',
            :sig=>get_email_hash(@tte_game.player_a_email),
          }
        }
      end
    end
  end
  
  test "restart should fail on bad sig" do
    @tte_game = Tte::Game.new({:player_a_email=>'a@patt.us', :player_b_email=>'b@patt.us'})
    @tte_game.save!
    @tte_turn = Tte::Turn.new({:board=> 43350, :game_id=>@tte_game.id, :number=>1})
    @tte_turn.save!
    
    assert_difference 'Tte::Turn.count', 0 do
      assert_difference 'ActionMailer::Base.deliveries.count', 0 do 
        get :restart, {
          :game_id=>@tte_game.to_param, 
          :tte_game => {
            :square=>8, 
            :current_player_email=>@tte_game.player_a_email,
            :sig=>'not vaild',
          }
        }
      end
    end
  end
  
end

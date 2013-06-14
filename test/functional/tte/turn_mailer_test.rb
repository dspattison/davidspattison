require 'test_helper'

class Tte::TurnMailerTest < ActionMailer::TestCase
  test 'send turn notify email' do
    tte_game = tte_games :one
    tte_turn = tte_turns :one
    
    email = Tte::TurnMailer.turn_notify(tte_game, tte_turn).deliver
    assert !ActionMailer::Base.deliveries.empty?
    
    
    assert_equal [tte_game.player_b_email], email.to
    
    assert_equal "[tic-tac-email] Your Move against #{tte_game.player_a_email}", email.subject
    
    
  end
  
  test 'game over email' do
    tte_game = tte_games :game_over_tie
    tte_turn = tte_turns :game_over_tie
    
    email = Tte::TurnMailer.game_over(tte_game, tte_turn, tte_game.player_a_email, tte_game.player_b_email).deliver
    assert !ActionMailer::Base.deliveries.empty?
    
    assert_equal [tte_game.player_a_email], email.to
  end
  
end

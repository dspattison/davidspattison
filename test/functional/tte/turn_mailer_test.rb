require 'test_helper'

class Tte::TurnMailerTest < ActionMailer::TestCase
  test 'send turn notify email' do
    tte_game = tte_games :one
    tte_turn = tte_turns :one
    
    email = Tte::TurnMailer.turn_notify(tte_game, tte_turn).deliver
    assert !ActionMailer::Base.deliveries.empty?
    
    
    assert_equal [tte_game.player_a_email], email.to
    
    assert_equal "[tic-tac-email] Your Move against MyString", email.subject
    
    
    assert_match(/#{tte_game.player_b_email}/, email.encoded)
    
  end
  
end

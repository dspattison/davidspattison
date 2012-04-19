class Tte::TurnMailer < ActionMailer::Base
  default :from => "tic-tac-email@patt.us"
  
  def turn_notify tte_game, last_turn
    
    @board = Tte::Board.new last_turn.board
    
    mail(:to => 'dspattison@gmail.com') do |format|
       format.html
    end
  end
end

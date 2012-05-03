class Tte::TurnMailer < ActionMailer::Base
  default :from => "dspattison@gmail.com"
  
  def turn_notify tte_game, last_turn
    
    @board = Tte::Board.new last_turn.board
    @tte_game = tte_game
    @last_turn = last_turn
    if last_turn.number % 2 == 1
      @other_player_name = tte_game.player_a_email
      @current_player = Tte::Board::TILE_X
      @current_player_name = tte_game.player_b_email
    else
      @other_player_name = tte_game.player_b_email
      @current_player = Tte::Board::TILE_O
      @current_player_name = tte_game.player_a_email
    end
    
    @subject = "[tic-tac-email] Your Move against #{@other_player_name}"
    
    
    
    mail(:to => @current_player_name, :subject=>@subject) do |format|
       format.html
    end
  end
  
  
  def tie current_player_email, other_player_email
    @subject = '[tic-tac-email] Tie Game!'
    
    @current_player_email = current_player_email
    @other_player_email = other_player_email
    
    mail(:to => @current_player_email, :subject=>@subject) do |format|
       format.html
    end
    
  end
end

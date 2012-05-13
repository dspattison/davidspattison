class Tte::TurnMailer < ActionMailer::Base
  default :from => "dspattison@gmail.com"
  helper 'tte/games'
  
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
  
  
  def game_over tte_game, last_turn, current_player_email, other_player_email
    @board = Tte::Board.new last_turn.board
    @tte_game = tte_game
    @last_turn = last_turn
    
    raise Exception.new("Game is not over") unless @board.game_over?
    @title = 'oops'
    if !@board.has_winner?
      @title = "Tie Game! against #{other_player_email}"
    else
      #XOR
      if (current_player_email == @tte_game.player_b_email) == (@board.winner == Tte::Board::TILE_X)
        #current player is the winner
        @title = "You Won against #{other_player_email} :)"
      else
        #current player is a LOSER!
        @title = "You Lost against #{other_player_email} :("
      end 
       
    end
    
    @current_player_email = current_player_email
    @other_player_email = other_player_email
    
    mail(:to => @current_player_email, :subject=>"[tic-tac-email] #{@title}") do |format|
       format.html
    end
    
  end
end

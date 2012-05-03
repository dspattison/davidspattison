module Tte::GamesHelper
  
  # makes a move
  # last_turn can be nil (if it is the first move)
  # throws exceptions if there is an issue
  # writes state to database 
  # sends the emails
  def perform_move tte_game, last_turn, square, tile
    logger.info "In Tte::GamesHelper::move!"
    logger.debug tte_game.inspect
    logger.debug last_turn.inspect
    logger.debug square.inspect
    logger.debug tile.inspect
    
    turn_number = last_turn.nil? ? 0 : last_turn.number+1
    @board = Tte::Board.new last_turn.nil? ? 0 : last_turn.board
    
    @board.move! square, tile # this will raise exceptions
    
    
    this_turn = Tte::Turn.new({:game_id=>tte_game.id, :number=>turn_number, :board => @board.board})
    this_turn.save!
    
    
    if !@board.game_over?
      begin
        Tte::TurnMailer.turn_notify(@tte_game, this_turn).deliver
      rescue Exception=>ex
        @message_class = 'warning'
        @message = 'oops, error sending the email'
      end
    else
      begin
        Tte::TurnMailer.tie(@tte_game.player_a_email, @tte_game.player_b_email).deliver
        Tte::TurnMailer.tie(@tte_game.player_b_email, @tte_game.player_a_email).deliver
      rescue Exception=>ex
        @message_class = 'warning'
        @message = 'oops, error sending the email'
      end
      
    end
    
    this_turn
  end
  
end

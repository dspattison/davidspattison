module C4::GamesHelper
  
  def move! c4_game, column
    logger.info "In C4::GamesHelper::move!"
    logger.debug c4_game.inspect
    logger.debug column.inspect
    
    board = C4::Board::new c4_game.board
    
    board.move! column
    
    c4_game.board = board.board
    
    c4_game.save! #commit!
    
    logger.info "Game over status; #{board.game_over?.inspect}"
    
    if board.game_over?
      puts "help"
    else
      #keep playing
      C4::TurnMailer.turn_notify(c4_game).deliver
    end
    
  end
end

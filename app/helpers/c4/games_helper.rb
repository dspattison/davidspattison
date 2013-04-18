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
  
  def get_move_hash c4_game, column
    #so you could guess this if you had the source code... which is pushed to github
    hasher = Hasher::Sha.new
    board = C4::Board.new c4_game.board
    hasher.hash :c4_move_hash, c4_game.id, board.turn_number, column 
  end
end

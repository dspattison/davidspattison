class C4::TurnMailer < ActionMailer::Base
  default :from => "dspattison@gmail.com"
  helper 'c4/games'
  
  
  
  def turn_notify c4_game
    @c4_game = c4_game
    @board = C4::Board.new c4_game.board
    
    if @board.turn_number % 2 == 1
      @other_player_name = c4_game.player_a_email
      @current_player = C4::Board::B
      @current_player_name = c4_game.player_b_email
    else
      @other_player_name = c4_game.player_b_email
      @current_player = C4::Board::A
      @current_player_name = c4_game.player_a_email
    end
    
    @subject = "[c4] Your Move against #{@other_player_name}"
    
    #for compatibility with _new.html.erb/game_over
    @current_player_email = @current_player_name
    
    logger.info "sending turn email"
    mail(:to => @current_player_name, :subject=>@subject) do |format|
       format.html
    end
    
    
  end
  
end
# $Id$
require "hasher/hasher_sha.rb"

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
    
    logger.info "Game over status; #{@board.game_over?.inspect}"
    if !@board.game_over?
      begin
        Tte::TurnMailer.turn_notify(@tte_game, this_turn).deliver
      rescue Exception=>ex
        @message_class = 'warning'
        @message = 'oops, error sending the email'
      end
    else
      begin
        Tte::TurnMailer.game_over(@tte_game, this_turn, @tte_game.player_a_email, @tte_game.player_b_email).deliver
        Tte::TurnMailer.game_over(@tte_game, this_turn, @tte_game.player_b_email, @tte_game.player_a_email).deliver
      rescue Exception=>ex
        @message_class = 'warning'
        @message = 'oops, error sending the email'
      end
      
    end
    
    this_turn
  end
  
  
  # gets a hash of the email addressed. 
  # only reveal to intended recipant
  # this is a permament "login" token
  def get_email_hash email
    hasher = Hasher::Sha.new
    hasher.hash :tte_email_hash, email
  end
  
  # gets a hash to determine authenticty of a move
  # moves should only be considered valid if this secret  
  # has been revealed
  def get_move_hash game_id, email, square_id, last_board
    #logger.info [:get_move_hash,  game_id, email, square_id, last_board].inspect
    hasher = Hasher::Sha.new
    hasher.hash :tte_move_hash, game_id, email, square_id, last_board
  end
  
  
  def get_pixel email
    t = Email::Analytics::Tracker.new 'UA-40646320-1'
    t.set :cid, Email::Analytics::get_visitor_id(email)
    t.set :t, :event
    t.set :ec, 'email' # category
    t.set :ea, 'open' # action
    t.set :el, 'label' # label
    t.send
  end
  
end
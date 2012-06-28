class Tte::GamesController < ApplicationController
  include Tte::GamesHelper
  # GET /tte/games
  # GET /tte/games.json
  def index
    #sames a new
    @tte_game = Tte::Game.new params[:tte_game]
    @board = Tte::Board.new 0
    render :action => 'new' 
  end

  # GET /tte/games/1
  # GET /tte/games/1.json
  def show
    @tte_game = Tte::Game.find(params[:id])
    
    #Tte::TurnMailer.turn_notify(@tte_game,Tte::Turn.find_by_game_id(@tte_game.id, :order => "number DESC")).deliver

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tte_game }
    end
  end

  # GET /tte/games/new
  # GET /tte/games/new.json
  def new
    @tte_game = Tte::Game.new params[:tte_game]
    @board = Tte::Board.new 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @tte_game }
    end
  end

  # GET /tte/games/1/edit
  def edit
    @tte_game = Tte::Game.find(params[:id])
    @board = Tte::Board.new(0)
  end

  # POST /tte/games
  # POST /tte/games.json
  def create
    @tte_game = Tte::Game.new(params[:tte_game])
    @board = Tte::Board.new 0
    
    success = true
    @tte_game.save! or success = false
    begin
      success and perform_move @tte_game, nil, params[:square].to_i, Tte::Board::TILE_X
    rescue Exception=>ex
      logger.error ex.inspect
      success = false
    end
    
    respond_to do |format|
      if success
        format.html { redirect_to @tte_game, :notice => 'Game was successfully created.' }
        format.json { render :json => @tte_game, :status => :created, :location => @tte_game }
      else
        format.html { render :action => "new" }
        format.json { render :json => @tte_game.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  # GET /tte/games/1/restart
  def restart
    #default vars. used if execption
    @tte_game = Tte::Game.new 
    @board = Tte::Board.new 0
    
    @old_tte_game = Tte::Game.find(params[:game_id])
    
    logger.debug @old_tte_game.inspect
    
    @current_player_email = params[:tte_game][:current_player_email]
    if @old_tte_game.player_a_email == @current_player_email
      @other_player_email = @old_tte_game.player_b_email
    elsif @old_tte_game.player_b_email == @current_player_email
      @other_player_email = @old_tte_game.player_a_email
    else
      @message_class = 'amber'
      @message = 'You have won second prize in a beauty contest, collect $10.'
      render 'new'
      return
    end
    
    #do sig check
    server_signature = get_email_hash(@current_player_email)
    signature = params[:tte_game][:sig].to_s
    if signature != server_signature
      logger.error "Signature does not match provided client:[#{signature}] server:[#{server_signature}]"
      @message_class = 'amber'
      @message = 'go to jail, do not pass go, do not collect 200 dollars'
      render 'new'
      return
    else
      logger.info "Signatures match!! [#{signature}]"
    end 
    
    @tte_game = Tte::Game.new(:player_b_email=>@current_player_email, :player_a_email=>@other_player_email)
    
    @board = Tte::Board.new 0
    
    #copied from create :(
    success = true
    @tte_game.save! or success = false
    begin
      success and perform_move @tte_game, nil, params[:square].to_i, Tte::Board::TILE_X
    rescue Exception=>ex
      logger.error ex.inspect
      success = false
    end
    
    respond_to do |format|
      if success
        format.html { redirect_to @tte_game, :notice => 'Game was successfully created.' }
        format.json { render :json => @tte_game, :status => :created, :location => @tte_game }
      else
        format.html { render :action => "new" }
        format.json { render :json => @tte_game.errors, :status => :unprocessable_entity }
      end
    end
    
  end

  # PUT /tte/games/1
  # PUT /tte/games/1.json
  def update
    @tte_game = Tte::Game.find(params[:id])

    respond_to do |format|
      if @tte_game.update_attributes(params[:tte_game])
        format.html { redirect_to @tte_game, :notice => 'Game was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @tte_game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tte/games/1
  # DELETE /tte/games/1.json
  def destroy
    @tte_game = Tte::Game.find(params[:id])
    @tte_game.destroy

    respond_to do |format|
      format.html { redirect_to tte_games_url }
      format.json { head :ok }
    end
  end
  
  def start
    
  end
  
  #advances the board with a turn
  def move
    @message = ''
    @message_class = ''
    @new_game_link = new_tte_game_path
    @board = Tte::Board.new 0
    begin
      @tte_game = Tte::Game.find(params[:game_id])
    rescue ActiveRecord::RecordNotFound => ex
      @message_class = 'alert'
      @message = 'game not found'
      render 
      return
    end
    
    
    player = params[:tte_game][:player].to_i
    square = params[:tte_game][:square].to_i
    signature = params[:tte_game][:sig].to_s
    last_turn = nil
    
    if player == Tte::Board::TILE_X
      @other_player_email = @tte_game.player_a_email
      @current_player = Tte::Board::TILE_X
      @current_player_email = @tte_game.player_b_email
    else
      @other_player_email = @tte_game.player_b_email
      @current_player = Tte::Board::TILE_O
      @current_player_email = @tte_game.player_a_email
    end
    @new_game_link = new_tte_game_path(
      :tte_game=>{
          :player_a_email=>@other_player_email, 
          :player_b_email=>@current_player_email})
    
    begin
      last_turn = Tte::Turn.find_by_game_id @tte_game.id, :order => "number DESC"
    rescue ActiveRecord::RecordNotFound => ex
      #handled in next clause
    end
    
    if last_turn.nil?
      @message_class = 'amber'
      @message = 'turn not found'
      render
      return
    end
    
    #do sig check
    server_signature = get_move_hash(@tte_game.id, @current_player_email, square, last_turn.board)
    if signature != server_signature
      logger.error "Signature does not match provided client:[#{signature}] server:[#{server_signature}]"
    else
      logger.info "Signatures match!! [#{signature}]"
    end
    
    
    begin
      this_turn = perform_move @tte_game, last_turn, square, player
    rescue Exception=>ex
      @message_class = 'warning'
      @message = ex.message
      render
      return
    end
    
    @board = Tte::Board.new this_turn.board
    if @board.has_winner?
      @message_class = 'good'
      @message ="You Won!!!"
      render
      return
    end
    
    if @board.game_over?
      @message_class = 'good'
      @message ="Tie Game!"
      render
      return
    end
    
    @message_class = 'good'
    @message ="Turn completed"
    render 
  end
end

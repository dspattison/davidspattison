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

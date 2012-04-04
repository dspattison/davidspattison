class Tte::GamesController < ApplicationController
  # GET /tte/games
  # GET /tte/games.json
  def index
    @tte_games = Tte::Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tte_games }
    end
  end

  # GET /tte/games/1
  # GET /tte/games/1.json
  def show
    @tte_game = Tte::Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tte_game }
    end
  end

  # GET /tte/games/new
  # GET /tte/games/new.json
  def new
    @tte_game = Tte::Game.new
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

    respond_to do |format|
      if @tte_game.save && Tte::Turn.new({:game_id => @tte_game.id, :number=>0, :board => params[:square]}).save
        
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
  
  def move
    begin
      @tte_game = Tte::Game.find(params[:game_id])
    rescue ActiveRecord::RecordNotFound => ex
      render 'new', :alert=>'game not found'
      return
    end
    
    player = params[:tte_game][:player].to_i
    square = params[:tte_game][:square].to_i
    begin
      last_turn = Tte::Turn.find_by_game_id @tte_game.id, :order => "number DESC"
    rescue ActiveRecord::RecordNotFound => ex
      redirect 'new', :alert=>'turn not found'
      return
    end
    
    logger.info last_turn.inspect
    
    @board = Tte::Board.new last_turn.board
    
    if @board.has_winner?
      render 'new', :notice => 'game already over'
      return
    end
    
    if !@board.legal_move? square
      render 'new', :alert => 'illegal move'
      return
    end
    
    @board.move! square, player
    
    this_turn = Tte::Turn.new({:game_id=>@tte_game.id, :number=>last_turn.number+1, :board => @board.board})
    this_turn.save
    
    
    render 'new', :notice=>'Turn completed'
  end
end

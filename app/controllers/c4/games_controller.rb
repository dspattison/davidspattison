class C4::GamesController < ApplicationController
  # GET /c4_games
  # GET /c4_games.json
  def index
    @c4_games = C4::Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @c4_games }
    end
  end

  # GET /c4_games/1
  # GET /c4_games/1.json
  def show
    @c4_game = C4::Game.find(params[:id])
    @board = C4::Board.new @c4_game.board

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @c4_game }
    end
  end

  # GET /c4_games/new
  # GET /c4_games/new.json
  def new
    @c4_game = C4::Game.new
    
    @board = C4::Board.new 0

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @c4_game }
    end
  end

  # GET /c4_games/1/edit
  def edit
    @c4_game = C4::Game.find(params[:id])
    @board = C4::Board.new @c4_game.board
  end

  # POST /c4_games
  # POST /c4_games.json
  def create
    @c4_game = C4::Game.new(params[:c4_game])
    
    @board = C4::Board.new 0
    #do first move
    @board.move! params[:column].to_i
    logger.debug "move! #{params[:column].inspect}, #{@board.columns}, #{@board.board}"
    
    @c4_game.board = @board.board

    respond_to do |format|
      if @c4_game.save
        format.html { redirect_to @c4_game, :notice => 'C4 game was successfully created.' }
        format.json { render :json => @c4_game, :status => :created, :location => @c4_game }
      else
        format.html { render :action => "new" }
        format.json { render :json => @c4_game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /c4_games/1
  # PUT /c4_games/1.json
  def update
    raise Exception.new("not allowed")
  end

  # DELETE /c4_games/1
  # DELETE /c4_games/1.json
  def destroy
    raise Exception.new("not allowed")
  end
end

class C4GamesController < ApplicationController
  # GET /c4_games
  # GET /c4_games.json
  def index
    @c4_games = C4Game.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @c4_games }
    end
  end

  # GET /c4_games/1
  # GET /c4_games/1.json
  def show
    @c4_game = C4Game.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @c4_game }
    end
  end

  # GET /c4_games/new
  # GET /c4_games/new.json
  def new
    @c4_game = C4Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @c4_game }
    end
  end

  # GET /c4_games/1/edit
  def edit
    @c4_game = C4Game.find(params[:id])
  end

  # POST /c4_games
  # POST /c4_games.json
  def create
    @c4_game = C4Game.new(params[:c4_game])

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
    @c4_game = C4Game.find(params[:id])

    respond_to do |format|
      if @c4_game.update_attributes(params[:c4_game])
        format.html { redirect_to @c4_game, :notice => 'C4 game was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @c4_game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /c4_games/1
  # DELETE /c4_games/1.json
  def destroy
    @c4_game = C4Game.find(params[:id])
    @c4_game.destroy

    respond_to do |format|
      format.html { redirect_to c4_games_url }
      format.json { head :ok }
    end
  end
end

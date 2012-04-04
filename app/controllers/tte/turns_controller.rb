class Tte::TurnsController < ApplicationController
  # GET /tte/turns
  # GET /tte/turns.json
  def index
    @tte_turns = Tte::Turn.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @tte_turns }
    end
  end

  # GET /tte/turns/1
  # GET /tte/turns/1.json
  def show
    @tte_turn = Tte::Turn.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @tte_turn }
    end
  end

  # GET /tte/turns/new
  # GET /tte/turns/new.json
  def new
    @tte_turn = Tte::Turn.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @tte_turn }
    end
  end

  # GET /tte/turns/1/edit
  def edit
    @tte_turn = Tte::Turn.find(params[:id])
  end

  # POST /tte/turns
  # POST /tte/turns.json
  def create
    @tte_turn = Tte::Turn.new(params[:tte_turn])

    respond_to do |format|
      if @tte_turn.save
        format.html { redirect_to @tte_turn, :notice => 'Turn was successfully created.' }
        format.json { render :json => @tte_turn, :status => :created, :location => @tte_turn }
      else
        format.html { render :action => "new" }
        format.json { render :json => @tte_turn.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tte/turns/1
  # PUT /tte/turns/1.json
  def update
    @tte_turn = Tte::Turn.find(params[:id])

    respond_to do |format|
      if @tte_turn.update_attributes(params[:tte_turn])
        format.html { redirect_to @tte_turn, :notice => 'Turn was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @tte_turn.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tte/turns/1
  # DELETE /tte/turns/1.json
  def destroy
    @tte_turn = Tte::Turn.find(params[:id])
    @tte_turn.destroy

    respond_to do |format|
      format.html { redirect_to tte_turns_url }
      format.json { head :ok }
    end
  end
end

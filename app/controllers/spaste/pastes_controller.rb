class Spaste::PastesController < ApplicationController
  include Spaste::PastesHelper
  # GET /spaste/pastes
  # GET /spaste/pastes.xml
  def index
    if params[:public_key]
      @spaste_pastes = Spates::Paste.find_by_key params[:public_key]
    else
      @spaste_pastes = Spaste::Paste.all
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @spaste_pastes }
    end
  end

  # GET /spaste/pastes/1
  # GET /spaste/pastes/1.xml
  def show
    @spaste_paste = Spaste::Paste.find(params[:id])
    if params[:secret_key]
      @spaste_paste = decrypt_paste(@spaste_paste, params[:secret_key])
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @spaste_paste }
    end
  end

  # GET /spaste/pastes/new
  # GET /spaste/pastes/new.xml
  def new
    @spaste_paste = Spaste::Paste.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @spaste_paste }
    end
  end

#  # GET /spaste/pastes/1/edit
#  def edit
#    @spaste_paste = Spaste::Paste.find(params[:id])
#  end

  # POST /spaste/pastes
  # POST /spaste/pastes.xml
  def create
    keys = new_key_set
    #raise Exception.new keys.inspect
    params[:spaste_paste] = encrypt_params params[:spaste_paste], keys[0]
    @spaste_paste = Spaste::Paste.new(params[:spaste_paste])

    respond_to do |format|
      if @spaste_paste.save
        format.html { redirect_to(spaste_paste_path(@spaste_paste, :secret_key=>keys[1]), :notice => 'Paste was successfully created.') }
        format.xml  { render :xml => @spaste_paste, :status => :created, :location => @spaste_paste }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @spaste_paste.errors, :status => :unprocessable_entity }
      end
    end
  end

#  # PUT /spaste/pastes/1
#  # PUT /spaste/pastes/1.xml
#  def update
#    @spaste_paste = Spaste::Paste.find(params[:id])
#
#    respond_to do |format|
#      if @spaste_paste.update_attributes(params[:spaste_paste])
#        format.html { redirect_to(@spaste_paste, :notice => 'Paste was successfully updated.') }
#        format.xml  { head :ok }
#      else
#        format.html { render :action => "edit" }
#        format.xml  { render :xml => @spaste_paste.errors, :status => :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /spaste/pastes/1
#  # DELETE /spaste/pastes/1.xml
#  def destroy
#    @spaste_paste = Spaste::Paste.find(params[:id])
#    @spaste_paste.destroy
#
#    respond_to do |format|
#      format.html { redirect_to(spaste_pastes_url) }
#      format.xml  { head :ok }
#    end
#  end
end

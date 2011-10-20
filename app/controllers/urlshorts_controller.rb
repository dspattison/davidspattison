class UrlshortsController < ApplicationController
  # GET /urlshorts
  # GET /urlshorts.xml
  def index
    @urlshorts = Urlshort.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @urlshorts }
    end
  end

  # GET /urlshorts/1
  # GET /urlshorts/1.xml
  def show
    @urlshort = Urlshort.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @urlshort }
    end
  end

  # GET /urlshorts/new
  # GET /urlshorts/new.xml
  def new
    @urlshort = Urlshort.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @urlshort }
    end
  end

  # GET /urlshorts/1/edit
  def edit
    @urlshort = Urlshort.find(params[:id])
  end

  # POST /urlshorts
  # POST /urlshorts.xml
  def create
    @urlshort = Urlshort.new(params[:urlshort])

    respond_to do |format|
      if @urlshort.save
        format.html { redirect_to(@urlshort, :notice => 'Urlshort was successfully created.') }
        format.xml  { render :xml => @urlshort, :status => :created, :location => @urlshort }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @urlshort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /urlshorts/1
  # PUT /urlshorts/1.xml
  def update
    @urlshort = Urlshort.find(params[:id])

    respond_to do |format|
      if @urlshort.update_attributes(params[:urlshort])
        format.html { redirect_to(@urlshort, :notice => 'Urlshort was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @urlshort.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /urlshorts/1
  # DELETE /urlshorts/1.xml
  def destroy
    @urlshort = Urlshort.find(params[:id])
    @urlshort.destroy

    respond_to do |format|
      format.html { redirect_to(urlshorts_url) }
      format.xml  { head :ok }
    end
  end
end

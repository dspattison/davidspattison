class RootController < ApplicationController
  def index
    #set STS for 1 month
    response.headers["Strict-Transport-Security"] =  "max-age=2592000; includeSubDomains"
    @urlshort = Urlshort.new
  end
  
  def tos
    #place holder for the legal page
  end
  
  def search
    # google custom search page
  end

end

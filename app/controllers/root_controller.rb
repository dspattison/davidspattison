class RootController < ApplicationController
  def index
    #set STS for 18 weeks, preload
    response.headers["Strict-Transport-Security"] =  "max-age=10886400; includeSubDomains; preload"
    @urlshort = Urlshort.new
  end
  
  def tos
    #place holder for the legal page
  end
  
  def search
    # google custom search page
  end

end

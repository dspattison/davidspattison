class RootController < ApplicationController
  def index
    #set STS for 1 month
    response.headers["Strict-Transport-Security"] =  "max-age=2592000; includeSubDomains"
    @urlshort = Urlshort.new
  end

end

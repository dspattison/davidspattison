class RootController < ApplicationController
  def index
    response.headers["Strict-Transport-Security"] =  "max-age=500;"
  end

end

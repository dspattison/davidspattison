class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_title
  
  private
  
  def set_title
      @page_title = 'David S Pattison'
  end
end

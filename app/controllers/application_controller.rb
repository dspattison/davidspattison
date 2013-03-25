class ApplicationController < ActionController::Base
  protect_from_forgery
  
  before_filter :set_title
  before_filter :set_html_title
  
  private
  
  def set_title
      @page_title = 'David S Pattison'
  end
  
  def set_html_title
    @page_html_title = @page_title
  end
end

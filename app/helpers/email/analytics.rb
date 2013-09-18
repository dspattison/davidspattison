require "hasher/hasher_sha.rb"
module Email::Analytics
  
  class Tracker
    
    def initialize account_id
      #@model = ActiveSupport::HashWithIndifferentAccess.new
      @model = Hash.new
      @model.set :tid, account_id
      @model.set :v, 1
    end
    
    
    def set k, v
      @model.set k.to_sym, v
    end
    
    def get
      @model.get k
    end
    
    # Todo type??
    def send
      build_hit
    end
    
    private
    def build_hit
      url = 'https://www.google-analytics.com/collect?'
      url += @model.to_query
      # @model.each do |k|
        # url += "#{k.html_safe}=#{@model[k].html_safe}&"
      # end
      url + 'z=' + rand(0x7fffffff).to_s
    end
  end
  
  def get_visitor_id email
    hasher = Hasher::Sha.new
    hasher.hash :salt, email, :pepper
  end
  
  
end

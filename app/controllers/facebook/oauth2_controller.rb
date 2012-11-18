class Facebook::Oauth2Controller < ApplicationController
  
  def auth
    fb_auth = FbGraph::Auth.new(app_id, app_secret)
    
    client = fb_auth.client
    client.redirect_uri = redirect_uri

    # redirect user to facebook
    redirect_to client.authorization_uri(
      :scope => [:email]
    )
    
  end

  def callback
    fb_auth = FbGraph::Auth.new(app_id, app_secret)
    client = fb_auth.client
    client.redirect_uri = redirect_uri
    client.authorization_code = params[:code]
    logger.info client.inspect
    access_token = client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
    
    #test that it works
    user_info = FbGraph::User.me(access_token).fetch # => FbGraph::User
    
    fbuser = Facebook::User.find_by_facebook_id(user_info.identifier)
    if fbuser.nil?
      fbuser = Facebook::User.new(
      {
        :app_id => app_id,
        :facebook_id => user_info.identifier,
        :status => 1,
      })
    end
    
    fbuser.email = user_info.email
    fbuser.name = user_info.name
    fbuser.auth = access_token.to_s
    
    fbuser.save
    redirect_to fyf_search_url(:access_token => access_token.to_s)
  end
  
  
  private
  #returns the internal application number
  def app_id 
    requested_app_id = params[:app_id]
    apps = Juggernaut[:facebook_app]
    if apps.has_key? requested_app_id
      return requested_app_id
    end
    # miss, go to primary
    if Juggernaut[:facebook_app_primary]
      return Juggernaut[:facebook_app_primary] 
    end
    
    #just pick one
    Juggernaut[:facebook_app].each do |k|
      return k # return first key
    end
    logger.error 'NO APP_ID KNOWN!!'
    nil 
  end
  
  def app_secret
    Juggernaut[:facebook_app][app_id]
  end
  
  def redirect_uri
    "http://localhost:3000/facebook/oauth2/callback?app_id=#{app_id}"
  end

end

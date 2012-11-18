class Facebook::Oauth2Controller < ApplicationController
  APP_ID = '294194040700417'
  APP_SECRET = '06e23e48c0c64239d364472589324e2a'
  INTERNAL_APP_ID = 1
  def auth
    fb_auth = FbGraph::Auth.new(APP_ID, APP_SECRET)
    
    client = fb_auth.client
    client.redirect_uri = "http://localhost:3000/facebook/oauth2/callback"

    # redirect user to facebook
    redirect_to client.authorization_uri(
      :scope => [:email, :read_stream, :offline_access]
    )
    
  end

  def callback
    fb_auth = FbGraph::Auth.new(APP_ID, APP_SECRET)
    client = fb_auth.client
    client.redirect_uri = "http://localhost:3000/facebook/oauth2/callback"
    client.authorization_code = params[:code]
    logger.info client.inspect
    access_token = client.access_token! :client_auth_body # => Rack::OAuth2::AccessToken
    
    #test that it works
    user_info = FbGraph::User.me(access_token).fetch # => FbGraph::User
    
    fbuser = Facebook::User.find_by_facebook_id(user_info.id)
    if fbuser.nil?
      fbuser = Facebook::User.new(
      {
        :app_id => INTERNAL_APP_ID,
        :facebook_id => user_info.id,
        # :email => user_info.email,
        # :name => user_info.name,
        # :auth => access_token.to_s,
        :status => 1,
      })
    end
    
    fbuser.email = user_info.email
    fbuser.name = user_info.name
    fbuser.auth = access_token.to_s
    
    fbuser.save
    respond_to do |format|
      format.html # new.html.erb
    end
  end

end

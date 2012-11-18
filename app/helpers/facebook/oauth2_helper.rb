module Facebook::Oauth2Helper
  def client
    fb_auth = FbGraph::Auth.new(APP_ID, APP_SECRET)
    
    client = fb_auth.client
    client.redirect_uri = "http://localhost:3000/facebook/oauth2/callback"
    client
  end
end

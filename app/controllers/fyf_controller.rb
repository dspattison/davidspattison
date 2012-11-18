class FyfController < ApplicationController
  def search
    @me = FbGraph::User.me(params[:access_token]).fetch
    @friends = @me.friends
    logger.info @friends
    
    @friends_other = []
    @friends_local = []
    
    ids = @friends.map{|f| f.identifier}
    
    local_users = {}
    Facebook::User.find_all_by_facebook_id(ids).each do |l|
      local_users[l.facebook_id] = l
    end
    
    logger.info local_users.inspect
    #local_user_ids = local_users.map{|l| l.facebook_id}
    #logger.info local_user_ids
    
    @friends.each do |f|
      if local_users.has_key? f.identifier.to_i
        @friends_local << [local_users[f.identifier.to_i], f]
      else 
        @friends_other << f
      end
    end
    
  end

end

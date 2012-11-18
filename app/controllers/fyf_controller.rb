class FyfController < ApplicationController
  def search
    user = FbGraph::User.me(params[:access_token]).fetch
    @friends = user.friends
    logger.info @friends
    
    @friends_other = []
    @friends_local = []
    
    ids = @friends.map{|f| f.identifier}
    
    local_users = Facebook::User.find_all_by_facebook_id ids
    logger.info local_users
    local_user_ids = local_users.map{|l| l.facebook_id}
    logger.info local_user_ids
    
    @friends.each do |f|
      if local_user_ids.include? f.identifier.to_i
        @friends_local << f
      else 
        @friends_other << f
      end
    end
    
  end

end

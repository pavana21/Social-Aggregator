class SocialInboxFeedsController < ApplicationController
  
  def index
    @feeds = current_user.social.social_inbox_feeds
    render json: @feeds
  end
end

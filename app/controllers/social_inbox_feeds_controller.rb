require 'will_paginate/array'
class SocialInboxFeedsController < ApplicationController  
  def index
    @feeds = current_user.social.social_inbox_feeds.search(params[:search]).paginate(:page => params[:page], :per_page => 10)
    respond_to :html, :js
  end
  
  def filter_feeds
    @feeds = current_user.social.social_inbox_feeds.where(inbox_type: params[:inbox_type]).search(params[:search]).paginate(:page => params[:page], :per_page => 10)
    respond_to :html, :js  
  end
end
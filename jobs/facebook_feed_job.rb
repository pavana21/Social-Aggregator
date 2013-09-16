class FacebookFeedJob
  @queue = :page_feeds

  def self.perform(social_profile_id)
    puts "Am Loaded"
    social = Social.find(social_profile_id)
    facebook_profile = social.facebook_profile
    
    if social.social_inbox_feeds.present? && social.social_inbox_feeds.inbox_type(SocialInboxFeed::INBOXTYPE::FACEBOOK).count > 0
      start_time = social.social_inbox_feeds.inbox_type(SocialInboxFeed::INBOXTYPE::FACEBOOK).last.updated_time.to_i
      persist_feeds(start_time, facebook_profile.facebook_oauth_token)
    else
      persist_feeds((Time.now - 3.months).to_i, facebook_profile.facebook_oauth_token, social)
    end
  end

  def self.persist_feeds(start_time, access_token, social)
      feeds = FacebookApi.home_feeds(start_time, access_token).sort_by {|_key, value| value}.reverse
      puts "Feeds: #{feeds}"
      feeds.each do |feed|
      social_inbox_feed = SocialInboxFeed.parse(feed, social)
    end
  end
end

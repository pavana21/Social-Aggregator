class FacebookFeedJob
  @queue = :page_feeds

  def self.perform(social_profile_id)
    social = Social.find(social_profile_id)
    facebook_profile = social.facebook_profile
    if social.social_inbox_feeds.inbox_type(SocialInboxFeed::INBOXTYPE::FACEBOOK).count > 0
      start_time = social.social_inbox_feeds.inbox_type(SocialInboxFeed::INBOXTYPE::FACEBOOK).last.updated_time.to_i
      persist_feeds(start_time, facebook_profile.access_token)
    else
      persist_feeds((Time.now - 3.months).to_i, facebook_profile.access_token)
    end
  end

  def self.persist_feeds(start_time, access_token)
    begin
      feeds = FacebookApi.home_feeds(start_time, access_token.sort_by {|_key, value| value}.reverse
    rescue => exc
    end
    feeds.each do |feed|
      social_inbox_feed = SocialInboxFeed.parse(feed)
      social_inbox_feed.save
    end
  end
end

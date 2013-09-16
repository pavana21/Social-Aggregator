class TwitterUserTimelineJob
  @queue = :tweet_messages

  def self.perform(social_id)
    social = Social.find(social_id)
    twitter_profile = social.twitter_profile
    user_timeline = social.social_inbox_feeds.where(inbox_type: SocialInboxFeed::INBOXTYPE::USERTIMELINE) if social.social_inbox_feeds.present?
    time_line = []
    if user_timeline.blank?
      time_line = twitter_profile.client.home_timeline
    else
      since_id = user_timeline.first.updated_time
      time_line = twitter_profile.client.home_timeline(since_id: "#{since_id}")
    end
    if time_line.present?
      time_line.each do |tweet|
        social_inbox_feed = SocialInboxFeed.parse_tweet(tweet, SocialInboxFeed::INBOXTYPE::USERTIMELINE, social)
        social.social_inbox_feeds << social_inbox_feed
        social_inbox_feed.save
      end
    end
  end
end
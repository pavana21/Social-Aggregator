class SocialInboxFeed < ActiveRecord::Base
  belongs_to :social

  module INBOXTYPE
    FACEBOOK = "facebook"
    USERTIMELINE = "user_timeline"
  end
  
  def self.parse(feed)
    social_inbox_feed =  SocialInboxFeed.find_or_create_by({feed_id: feed["id"]})

    social_inbox_feed.update_attributes({message: feed["message"], story: feed["story"],
      photo: feed["picture"], link: feed["link"], created_time: Time.parse(feed["created_time"]),
      updated_time: Time.parse(feed["updated_time"]), user_name: feed["from"]["name"], feed_type: feed["type"],
      inbox_type: INBOXTYPE::FACEBOOK, user_id: feed["from"]["id"]})
    social_inbox_feed
  end  

  def facebook?
    self["inbox_type"] == INBOXTYPE::FACEBOOK
  end

  def twitter?
    self["inbox_type"] == INBOXTYPE::USERTIMELINE
  end
  
  def self.parse_tweet(tweet, inbox_type)
    social_inbox_feed =  SocialInboxFeed.find_or_create_by({tweet_id: tweet.id})

    social_inbox_feed.update_attributes({message: tweet.text, created_time: tweet.created_at,
     updated_time: tweet.created_at, user_id: tweet.user.id, user_name: tweet.user.name,
     user_picture: tweet.user.profile_image_url_https, inbox_type: inbox_type, screen_name: tweet.user.screen_name,
     media: tweet.user.status.media.try(:first).try(:media_url_https),
     mentions: tweet.user_mentions.collect{|x| x[:screen_name]}, reply_to_status_id: tweet.in_reply_to_status_id})
    social_inbox_feed
  end
  

end
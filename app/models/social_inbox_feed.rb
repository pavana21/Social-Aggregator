class SocialInboxFeed < ActiveRecord::Base
  belongs_to :social

  module INBOXTYPE
    FACEBOOK = "facebook"
    USERTIMELINE = "home_timeline"
    LINKEDIN = "linkedin"
  end
  
  def self.parse(feed, social)
    social_inbox_feed =  SocialInboxFeed.find_or_create_by({feed_id: feed["id"]})
    social_inbox_feed.update_attributes({message: feed["message"], story: feed["story"],
      photo: feed["picture"], link: feed["link"], created_time: Time.parse(feed["created_time"]),
      updated_time: Time.parse(feed["updated_time"]), user_name: feed["from"]["name"], social_id: social.id, 
      inbox_type: INBOXTYPE::FACEBOOK, user_id: feed["from"]["id"]})
      puts "Social Inbox Feed: #{social_inbox_feed.inspect}"
    social_inbox_feed
  end  
  
  def self.search(search)
    if search
      find(:all, :conditions => ['user_name LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end

  def facebook?
    self["inbox_type"] == INBOXTYPE::FACEBOOK
  end

  def twitter?
    self["inbox_type"] == INBOXTYPE::USERTIMELINE
  end

  def linkedin?
    self["inbox_type"] == INBOXTYPE::LINKEDIN
  end
  
  def self.parse_tweet(tweet, inbox_type, social)
    social_inbox_feed =  SocialInboxFeed.find_or_create_by({tweet_id: tweet.id})

    social_inbox_feed.update_attributes({message: tweet.text, created_time: tweet.created_at,
     updated_time: tweet.created_at, user_id: tweet.user.id, user_name: tweet.user.name,
     inbox_type: inbox_type, social_id: social.id})
    social_inbox_feed
  end
end
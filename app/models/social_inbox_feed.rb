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

end
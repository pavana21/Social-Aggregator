class FacebookProfile < ActiveRecord::Base
  class << self
    def graph(facebook_oauth_token)
      Koala::Facebook::API.new(facebook_oauth_token)
    end

    def home_feeds(start_time, access_token)
      puts "Access Token : #{access_token}"
      puts "Object: #{graph(access_token).get_object('me')}"
      graph(access_token).get_connections("me", "home", {:since => start_time + 1, :until => Time.now.to_i})
    end

    def feed(access_token, feed_id)
      graph(access_token).get_object(feed_id)
    end
    
    def user_details(access_token)
      graph(access_token).get_object("me")
    end
  end
end

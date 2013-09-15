class TwitterProfile < ActiveRecord::Base
  belongs_to :social
  
  def find_for_oauth(auth)
    if !((twitter_oauth_token == auth.credentials["token"]) &&
      (twitter_uid == auth.uid) && (twitter_oauth_secret_token == auth.credentials["secret"]))
      self.update_attributes(twitter_oauth_token: auth.credentials["token"],
      twitter_uid: auth.uid, twitter_oauth_secret_token: auth.credentials["secret"])
      create_twitter
    end
  end
  
  def create_twitter
    Resque.enqueue(TwitterDetailsJob, self.id)
  end
end
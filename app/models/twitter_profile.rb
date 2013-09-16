class TwitterProfile < ActiveRecord::Base
  belongs_to :social

  def authorized?
    twitter_oauth_token.present?
  end
  
  def find_for_oauth(auth)
    if !((twitter_oauth_token == auth.credentials["token"]) &&
      (twitter_uid == auth.uid) && (twitter_oauth_secret_token == auth.credentials["secret"]))
      self.update_attributes(twitter_oauth_token: auth.credentials["token"],
      twitter_uid: auth.uid, twitter_oauth_secret_token: auth.credentials["secret"])
    end
    create_twitter
  end
  
  def create_twitter
    Resque.enqueue(TwitterDetailsJob, self.id)
  end
  
  def client
    Twitter::Client.new(
      :oauth_token => TwitterProfile.last.twitter_oauth_token,
      :oauth_token_secret => TwitterProfile.last.twitter_oauth_secret_token
    )
  end
end
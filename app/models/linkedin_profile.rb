class LinkedinProfile < ActiveRecord::Base
  belongs_to :social

  def authorized?
    linkedin_oauth_token.present?
  end
  
  def find_for_oauth(auth)
    if !((linkedin_oauth_token == auth.credentials["token"]) &&
      (linkedin_uid == auth.uid) && (linkedin_oauth_secret_token == auth.credentials["secret"]))
      self.update_attributes(linkedin_oauth_token: auth.credentials["token"],
      linkedin_uid: auth.uid, linkedin_oauth_secret_token: auth.credentials["secret"])
    end
  end
  
  def client
    client = LinkedIn::Client.new("ni01x8rzbbga", "FyxHaqIlXoF6c4d5")
    client.authorize_from_access(linkedin_oauth_token, linkedin_oauth_secret_token)
    client
  end
end
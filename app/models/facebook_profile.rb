class FacebookProfile < ActiveRecord::Base
  belongs_to :social

  def authorized?
    facebook_oauth_token.present?
  end

  def find_for_oauth(auth)
    if !((facebook_oauth_token == auth.credentials["token"]) && (facebook_uid == auth.uid))      
      self.update_attributes!(facebook_oauth_token: auth.credentials["token"], facebook_uid: auth.uid)
    end
    Resque.enqueue(FacebookProfileDetailsJob, social.id)
  end
end
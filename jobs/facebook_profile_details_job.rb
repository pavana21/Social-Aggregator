class FacebookProfileDetailsJob
  @queue = :facebook_worker

  def self.perform(social_profile_id)
    social = Social.find(social_profile_id)
    facebook_profile = social.facebook_profile
    facebook_oauth_token = facebook_profile.facebook_oauth_token
    if facebook_oauth_token.present? && facebook_profile.facebook_uid.present?
      update_profile(access_token, facebook_profile)
    end
  end

  def self.update_profile(access_token, facebook_profile)
    page_details = FacebookApi.user_details(access_token)
    city = page_details["location"].present? ? page_details["location"]["city"] : ""
    attributes = {name: page_details["name"],
                  description: page_details["description"],
                  about: page_details["about"],
                  location: city,
                  url: page_details["website"]}
    facebook_profile.update_attributes(attributes)
  end
end
class TwitterDetailsJob
  @queue = :twitter_worker

  def self.perform(id)
    twitter_profile = TwitterProfile.find(id)
    create_profile_for(twitter_profile)
  end

  def self.create_profile_for(twitter_profile)
    user = twitter_profile.client.user
    attributes = {name: user.name,
                  description: user.description,
                  location: user.location,
                  url: user.url}

    twitter_profile.update_attributes(attributes)
  end
end
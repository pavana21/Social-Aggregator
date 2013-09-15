class TwitterAllAccountsFetchJob
  @queue = :tweet_messages

  class << self
    def perform
      Social.all.each do |social|
        Resque.enqueue(TwitterDetailsJob, social.twitter_profile.id)
        Resque.enqueue(TwitterUserTimelineJob, social.id)
      end
    end
  end
end

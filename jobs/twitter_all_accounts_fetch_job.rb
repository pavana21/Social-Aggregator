class TwitterAllAccountsFetchJob
  @queue = :tweet_messages

  class << self
    def perform
      Social.all.each do |social|
        Resque.enqueue(TwitterUserTimelineJob, social.id)
      end
    end
  end
end

class FacebookAllAccountsFetchJob
  @queue = :page_feeds

  class << self
    def perform
      Social.all.each do |social|
        if social.facbook_profile.authorized?
          Resque.enqueue(FacebookFeedJob, social.id)
        end
      end
    end
  end
end

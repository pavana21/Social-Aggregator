class FacebookAllAccountsFetchJob
  @queue = :page_feeds

  class << self
    def perform
      Social.all.each do |social|
        if social.facbook_profile.page_selected?
          Resque.enqueue(FacebookFeedJob, social._id)
          Resque.enqueue(FacebookProfileDetailsJob, social._id, social.facebook_profile.page_id)
        end
      end
    end
  end
end

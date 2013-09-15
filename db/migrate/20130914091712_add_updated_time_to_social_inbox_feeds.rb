class AddUpdatedTimeToSocialInboxFeeds < ActiveRecord::Migration
  def change
    add_column :social_inbox_feeds, :updated_time, :datetime
  end
end

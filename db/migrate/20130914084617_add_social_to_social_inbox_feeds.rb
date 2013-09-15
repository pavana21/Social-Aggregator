class AddSocialToSocialInboxFeeds < ActiveRecord::Migration
  def change
    add_column :social_inbox_feeds, :social_id, :integer
  end
end

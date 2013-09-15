class CreateSocialInboxFeeds < ActiveRecord::Migration
  def change
    create_table :social_inbox_feeds do |t|
      t.string :feed_id
      t.string :tweet_id
      t.text :message
      t.string :story
      t.string :photo
      t.string :link
      t.datetime :created_time
      t.string :user_id
      t.string :inbox_type
      t.string :user_name

      t.timestamps
    end
  end
end

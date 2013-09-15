class AddFieldsToTwitterProfile < ActiveRecord::Migration
  def change
    add_column :twitter_profiles, :name, :string
    add_column :twitter_profiles, :description, :string
    add_column :twitter_profiles, :url, :string
    add_column :twitter_profiles, :location, :string
    add_column :twitter_profiles, :twitter_oauth_token, :string
    add_column :twitter_profiles, :twitter_oauth_secret_token, :string
    add_column :twitter_profiles, :twitter_uid, :string    
  end
end

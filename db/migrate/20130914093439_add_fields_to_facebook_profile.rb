class AddFieldsToFacebookProfile < ActiveRecord::Migration
  def change
    add_column :facebook_profiles, :name, :string
    add_column :facebook_profiles, :description, :string
    add_column :facebook_profiles, :about, :string
    add_column :facebook_profiles, :location, :string
    add_column :facebook_profiles, :url, :string
    add_column :facebook_profiles, :facebook_oauth_token, :string
    add_column :facebook_profiles, :facebook_uid, :string
    add_column :facebook_profiles, :access_token, :string
    
  end
end

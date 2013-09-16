class AddFieldsToLinkedinProfile < ActiveRecord::Migration
  def change
    add_column :linkedin_profiles, :name, :string
    add_column :linkedin_profiles, :description, :string
    add_column :linkedin_profiles, :about, :string
    add_column :linkedin_profiles, :location, :string
    add_column :linkedin_profiles, :url, :string
    add_column :linkedin_profiles, :linkedin_oauth_token, :string
    add_column :linkedin_profiles, :linkedin_oauth_secret_token, :string
    add_column :linkedin_profiles, :linkedin_uid, :string
    add_column :linkedin_profiles, :access_token, :string

  end
end

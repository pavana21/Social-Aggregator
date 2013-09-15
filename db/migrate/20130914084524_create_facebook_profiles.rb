class CreateFacebookProfiles < ActiveRecord::Migration
  def change
    create_table :facebook_profiles do |t|
      t.integer :social_id

      t.timestamps
    end
  end
end

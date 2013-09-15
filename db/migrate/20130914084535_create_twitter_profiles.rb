class CreateTwitterProfiles < ActiveRecord::Migration
  def change
    create_table :twitter_profiles do |t|
      t.integer :social_id

      t.timestamps
    end
  end
end

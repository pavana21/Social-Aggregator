class CreateLinkedinProfiles < ActiveRecord::Migration
  def change
    create_table :linkedin_profiles do |t|
      t.integer :social_id

      t.timestamps
    end
  end
end

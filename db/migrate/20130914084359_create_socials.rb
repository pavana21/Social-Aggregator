class CreateSocials < ActiveRecord::Migration
  def change
    create_table :socials do |t|
      t.integer :user_id

      t.timestamps
    end
  end
end

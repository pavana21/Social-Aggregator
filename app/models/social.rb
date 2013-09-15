class Social < ActiveRecord::Base

  has_one     :facebook_profile, autosave: true
  has_one     :twitter_profile, autosave: true
  has_one     :linkedin_profile, autosave: true
  has_many    :social_inbox_feeds
  belongs_to  :user 
end

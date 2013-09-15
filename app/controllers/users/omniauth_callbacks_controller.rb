class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :social_profiles

  def facebook
    current_user.social.facebook_profile.find_for_oauth(request.env["omniauth.auth"])
    current_user.social.save
    redirect_to :back
  end

  def twitter
    current_user.social.twitter_profile.find_for_oauth(request.env["omniauth.auth"])
    current_user.social.save
    redirect_to social_login_details_accounts_path
  end
  
  private
  def social_profiles
    unless current_user.social.present?
      @social = current_user.build_social
      @social.save
      FacebookProfile.create(social_id: @social.id)
      TwitterProfile.create(social_id: @social.id)
    end
  end
end
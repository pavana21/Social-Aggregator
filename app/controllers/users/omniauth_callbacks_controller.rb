class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_filter :social_profiles

  def facebook
    current_user.social.facebook_profile.find_for_oauth(request.env["omniauth.auth"])
    redirect_to root_url
  end

  def twitter
    current_user.social.twitter_profile.find_for_oauth(request.env["omniauth.auth"])
    redirect_to root_url
  end

  def linkedin
    current_user.social.linkedin_profile.find_for_oauth(request.env["omniauth.auth"])
    redirect_to root_url
  end
  
  private
  def social_profiles
    unless current_user.social.present?
      @social = current_user.build_social
      @social.save
      @fp = @social.build_facebook_profile
      @fp.save
      @tp = @social.build_twitter_profile
      @tp.save
      @linkedin = @social.build_linkedin_profile
      @linkedin.save
    end
  end
end
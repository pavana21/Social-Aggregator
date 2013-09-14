class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    current_user.facebook_profile.find_for_oauth(request.env["omniauth.auth"])
    current_user.social.save
    redirect_to social_login_details_accounts_path
  end

  def twitter
    current_user.twitter_profile.find_for_oauth(request.env["omniauth.auth"])
    current_user.social.save
    redirect_to social_login_details_accounts_path
  end

end
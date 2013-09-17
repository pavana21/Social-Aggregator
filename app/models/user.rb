class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise    :database_authenticatable, :registerable,
            :recoverable, :rememberable, :trackable, :validatable, :omniauthable
         
  has_one   :social
  
  def check_social_profile?(profile)
    profile.present? && profile.authorized?
  end
end
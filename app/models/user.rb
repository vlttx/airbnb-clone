class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and 
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable,  :omniauth_providers => [:facebook]
  validates :fullname, presence: true, length: {maximum: 50}


    def self.from_omniauth(auth)
      user = User.where(email: auth.info.email).first 
      if user
      return user
      else	
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      	user.provider = auth.provider
      	user.uid = auth.uid
        user.fullname = auth.info.name
        user.email = auth.info.email
        user.image = auth.info.image
        user.password = Devise.friendly_token[0,10]
      end
    end
end
end


# we have self in the method because we want to use it without initializing a new instance of User

# we check if we got that email in our database or if not, we create it

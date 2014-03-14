class User < ActiveRecord::Base
	before_save :hash_stuff

	attr_accessor :password

	def authenticated?(pwd)
		self.hashed_password ==
		BCrypt::Engine.hash_secret(pwd, self.salt)
	end

def self.from_omniauth(auth)
   where(auth.slice(:provider, :uid)).first_or_initialize.tap do |user|
    user.provider = auth.provider
    user.uid = auth.uid
    user.name = auth.info.name
    user.username = auth.extra.raw_info.username
    user.oauth_token = auth.credentials.token
    user.oauth_expires_at = Time.at(auth.credentials.expires_at)
    user.save!
  	end
end

	private

	def hash_stuff
		self.salt = BCrypt::Engine.generate_salt
		self.hashed_password =
		BCrypt::Engine.hash_secret(password, self.salt)
		self.password = nil 
	end 

end

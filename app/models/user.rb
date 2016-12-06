class User < ApplicationRecord
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	def admin?
	self.role == "admin"
	end
	
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :omniauthable, :omniauth_providers => [:facebook]

	has_many :topics , :dependent => :destroy
	has_many :comments , :dependent => :destroy
	has_many :favorites , :dependent => :destroy
	has_many :favorited_topics , :through => :favorites , :source => :topic
	has_many :likes , :dependent => :destroy
	has_many :liked_topics , :through => :likes , :source => :topic
	has_many :subscribes , :dependent => :destroy
	has_many :subscribed_topics , :through => :subscribes , :source => :topic
	has_many :friendships , :dependent => :destroy
	has_many :friends, :through => :friendships , :dependent => :destroy
	has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
	has_many :inverse_friends, :through => :inverse_friendships, :source => :user


	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "50x50>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/

  	def get_fb_data
 		j = RestClient.get "https://graph.facebook.com/v2.5/me", :params => { :access_token => self.fb_token, :fields => "id,name,email,picture" }
 		JSON.parse(j)
	end

	def self.from_omniauth(auth)
	     # Case 1: Find existing user by facebook uid
	     user = User.find_by_fb_uid( auth.uid )
	     if user
	        user.fb_token = auth.credentials.token
	        user.avatar_file_name = auth.info.image
	        #user.fb_raw_data = auth
	        user.save!
	       return user
	     end

	     # Case 2: Find existing user by email
	     existing_user = User.find_by_email( auth.info.email )
	     if existing_user
	       existing_user.fb_uid = auth.uid
	       existing_user.fb_token = auth.credentials.token
	       existing_user.avatar_file_name = auth.info.image
	       #existing_user.fb_raw_data = auth
	       existing_user.save!
	       return existing_user
	     end

	     # Case 3: Create new password
	     user = User.new
	     user.fb_uid = auth.uid
	     user.fb_token = auth.credentials.token
	     user.avatar_file_name = auth.info.image
	     user.email = auth.info.email
	     user.password = Devise.friendly_token[0,20]
	     #user.fb_raw_data = auth
	     user.save!
	     return user
	end

	

end

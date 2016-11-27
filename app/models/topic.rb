class Topic < ApplicationRecord
	validates_presence_of :t_content , :counter_cache => true

	belongs_to :user
	has_many :comments , :dependent => :destroy
	has_many :category_topicships , :dependent => :destroy
	has_many :categories , :through => :category_topicships , :dependent => :destroy
	has_many :favorites , :dependent => :destroy
	has_many :favorited_users , :through => :favorites , :source => :user
	has_many :likes , :dependent => :destroy
	has_many :liked_users , :through => :likes , :source => :user
	has_many :subscribes , :dependent => :destroy
	has_many :subscribed_users , :through => :subscribes , :source => :user
	has_many :tag_topicships , :dependent => :destroy
	has_many :tags , :through => :tag_topicships , :dependent => :destroy

	delegate :id , :to => :categories , :prefix => true , :allow_nil => true

	has_attached_file :avatar, styles: { medium: "300x300>", thumb: "100x100>" }, default_url: "/images/:style/missing.png"
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\z/
	
end

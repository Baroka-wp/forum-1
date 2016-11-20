class Topic < ApplicationRecord
	validates_presence_of :t_content , :counter_cache => true

	belongs_to :user
	has_many :comments , :dependent => :destroy
	has_many :category_topicships , :dependent => :destroy
	has_many :categories , :through => :category_topicships , :dependent => :destroy

	delegate :id , :to => :categories , :prefix => true , :allow_nil => true
end

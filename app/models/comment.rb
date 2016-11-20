class Comment < ApplicationRecord
	validates_presence_of :c_content

	belongs_to :topic , :counter_cache => true
	belongs_to :user 
end

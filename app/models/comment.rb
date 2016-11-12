class Comment < ApplicationRecord
	validates_presence_of :c_content

	belongs_to :topic
	belongs_to :user
end

class Comment < ApplicationRecord
	validates_presence_of :c_content

	belongs_to :topic , :dependent => :destroy
	belongs_to :user , :dependent => :destroy
end

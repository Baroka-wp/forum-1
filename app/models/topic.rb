class Topic < ApplicationRecord
	validates_presence_of :t_content

	belongs_to :user , :dependent => :destroy
	has_many :comments , :dependent => :destroy
	has_many :category_topicships , :dependent => :destroy
	has_many :categories , :through => :category_topicships , :dependent => :destroy

end

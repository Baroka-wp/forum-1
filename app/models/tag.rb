class Tag < ApplicationRecord
	has_many :tag_topicships , :dependent => :destroy
	has_many :tags , :through => :tag_topicships , :dependent => :destroy
end

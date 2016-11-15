class Category < ApplicationRecord
	has_many :category_topicships , :dependent => :destroy
	has_many :topics , :through => :category_topicships , :dependent => :destroy
end

class CategoryTopicship < ApplicationRecord
	belongs_to :category , :dependent => :destroy
	belongs_to :topic , :dependent => :destroy
end

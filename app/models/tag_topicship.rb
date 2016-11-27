class TagTopicship < ApplicationRecord
	belongs_to :tag
	belongs_to :topic
end

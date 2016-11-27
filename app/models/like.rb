class Like < ApplicationRecord
	belongs_to :user 
	belongs_to :topic , :counter_cache => true
end

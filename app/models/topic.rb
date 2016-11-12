class Topic < ApplicationRecord
	validates_presence_of :t_content

	belongs_to :user
	has_many :comments
end

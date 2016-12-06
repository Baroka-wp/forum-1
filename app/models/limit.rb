class Limit < ApplicationRecord
	has_many :topics , :dependent => :destroy
end

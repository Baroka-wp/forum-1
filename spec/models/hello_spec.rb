require 'rails_helper'

describe 'Hello' do
	it {
		@tag = Tag.new(:name => "dfdsdf")
		expect(@tag.save).not_to eq(false)
	}
end
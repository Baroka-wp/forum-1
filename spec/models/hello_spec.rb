<<<<<<< HEAD
require 'rails_helper'

describe 'Hello' do
	it {
		@tag = Tag.new(:name => "dfdsdf")
		expect(@tag.save).not_to eq(false)
	}
end
||||||| merged common ancestors
=======
require 'rails_helper'

describe 'Hello' do
	let(:c) do
		c = Tag.new(:name => "dsfdsfs")
	end

	it {
		expect(c.save).to eq(true)
	}
end
>>>>>>> feature

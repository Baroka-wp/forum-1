require 'rails_helper'

describe 'Hello' do
	let(:c) do
		c = Tag.new(:name => "dsfdsfs")
	end

	it {
		expect(c.save).to eq(true)
	}
end
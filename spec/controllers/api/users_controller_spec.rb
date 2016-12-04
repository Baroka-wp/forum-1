require 'rails_helper'
#bundle exec rspec
RSpec.describe Api::UsersController, type: :controller do
	let!(:user) { User.create!(:email => "aaa@ufsdf" , :password => "11111111") }
	it "#index" do 
		request.headers['HTTP_X_TOKEN'] = '123456'
		get :index
		expect(response.status).to eq(200)
	end

	describe '#create' do
		it 'success case' do
			expect {
				post :create , 
				params: { user: { email: 'ffsfsds@dsdfsd.com' , password: '12345678'} }
			}.to change {User.count}.by(1)
			expect(response.status).to eq(200)
		end
	end
end

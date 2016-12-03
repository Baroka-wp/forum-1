equire 'rails_helper'
#bundle exec rspec
RSpec.describe Api::UsersController, type: :request do

	it "#index" do 
		# request.headers['HTTP_X_TOKEN'] = '123456'
		get '/api/users.json' ,
		 params: { abc: 1 } , 
		 :headers => { 'HTTP_X_TOKEN' => '123456'}
		expect(response.status).to eq(200)
		
	end
end
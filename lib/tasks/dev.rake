namespace :dev do 
	task :rebuild => ["db:reset" , :fake]
	task :fake do
		Limit.create(:name => "只有自己可以看")
		Limit.create(:name => "限好友才能看跟留言")
		Limit.create(:name => "別人只能看不能留言")
		Limit.create(:name => "別人可以看也能留言")
		
		User.create( :email => "blacks@yahoo.com.tw" , :password => "123456" )
		10.times do
			User.first.topics.create(	:limit_id => 4,
										:title => Faker::Pokemon.name,
										:content => Faker::Lorem.sentence(100),
										:user_id =>	1,
										:draft => false
									)
		end

		10.times do
			e = User.create(:email => Faker::Internet.email , :password => "123456" )
			10.times do |i|
				e.topics.create(	:limit_id => 4,
									:title => Faker::Pokemon.name,
									:content => Faker::Lorem.sentence(100),
									:user_id =>	e.id,
									:draft => false
								)
			end
		end
	end
end
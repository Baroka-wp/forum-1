namespace :dev do 
	task :rebuild => ["db:reset" , :fake]
	task :fake do
		User.create( :email => "blacks@yahoo.com.tw" , :password => "123456" )
		10.times do
			User.first.topics.create(	:tital => Faker::Lorem.word,
										:t_content => Faker::Lorem.sentence(100),
										:t_time => Faker::Time.between(2.days.ago, Date.today, :all),
										:user_id =>	1)
		end

		10.times do
			e = User.create(:email => Faker::Internet.email , :password => "123456" )
			10.times do |i|
				e.topics.create(	:tital => Faker::Lorem.word,
									:t_content => Faker::Lorem.sentence(100),
									:t_time => Faker::Time.between(2.days.ago, Date.today, :all),
									:user_id =>	i)
			end
		end
	end
end
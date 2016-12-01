json.array! @users do |user|
	#json.partial! 'user' , user: user
	json.id user.id
	json.email user.id
end
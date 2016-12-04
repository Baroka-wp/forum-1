<<<<<<< HEAD
class Api::UsersController < Api::BaseController
	#$.get('http://localhost:3000/api/users.json', null, function(data) { console.log(data); });
	# $.ajax({
	#   url: "http://api.localhost:3000/api/users/3.json",
	#   method: "POST",
	#   success: function(data) { console.log(data) }
	# })


	def index
		@users = User.all
		render json: { users: @users }
	end

	def show 
		#response.headers['Content-Type'] = "HTML"
		@user = User.find(params[:id])
		render json: { user: @user } #, status: 40
	end

	def create
		@user = User.all
		render json: { user: @user } #, status: 40
	end
end
||||||| merged common ancestors
=======
class Api::UsersController < Api::BaseController
	#$.get('http://localhost:3000/api/users.json', null, function(data) { console.log(data); });
	# $.ajax({
	#   url: "http://api.localhost:3000/api/users/3.json",
	#   method: "POST",
	#   success: function(data) { console.log(data) }
	# })
	# data: { turbolinks: 'false' }
	before_action(except: [:index]) { add_crumb('Users', admin_users_path) }



	def index
		@users = User.all
		render json: { users: @users }
	end

	def show 
		#response.headers['Content-Type'] = "HTML"
		@user = User.find(params[:id])
		render json: { user: @user } #, status: 40
	end

		
	def create
	  	@user = User.new(params.require(:user).permit(:email , :password))
	  	if @user.save
	  		render json: {user: @user}
	  	else
	  		respond_error messages :@user.errors.full_messages
	  	end
  	end
end
>>>>>>> feature

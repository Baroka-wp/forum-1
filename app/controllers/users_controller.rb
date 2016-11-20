class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def profile
		@user = current_user
		@topics = @user.topics
		@comments = @user.comments
	end

	def update
		@user = User.new(params.require(:user).permit(:nickname , :current_password ))
		if @user.save
			flash[:notice] = "更新成功"
			redirect_to profile_users_path
		else
			flash[:notice] = "更新失敗"
			render 
		end
	end

end

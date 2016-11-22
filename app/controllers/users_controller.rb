class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end

	def profile
		@user = current_user
		@topics = @user.topics
		@comments = @user.comments
	end

	def favorite
		@user = current_user
		@favorites = @user.favorites
	end

	def draft
		@user = current_user
		@topics = @user.topics.where( :draft => true)
		@comments = @user.comments.where( :draft => true)
	end

	def update_draft
		@topic = Topic.find(params[:topic_id])
		if @topic.update(params.require(:topic).permit(:draft , :title))
			flash[:notice] = "OOOO"
			redirect_to draft_users_path
		else
			flash[:alert] = "XXXX"
			render "draft"
		end
	end

	# def favorite
	# 	@user = current_user
	# 	@favorite = Favorite.where( :user_id => @user.id )
	# end

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

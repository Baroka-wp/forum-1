class UsersController < ApplicationController

	def index
		@users = User.where.not(:id => current_user)
	end

	def show
		@user = User.find(params[:id])
	end

	def update 
		@user = current_user
		if @user.update(write_user)
			flash[:notice] = "OOOO"
			redirect_to profile_users_path(:useremail => current_user.email)
		else
			flash[:alert] = "XXXX"
			render "profile"
		end
	end

	def profile
		@user = User.find_by(email: params[:useremail])
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
		if @topic.update(params.require(:topic).permit(:draft , :title , :content))
			flash[:notice] = "OOOO"
			redirect_to draft_users_path
		else
			flash[:alert] = "XXXX"
			render "draft"
		end
	end

	def like
		@user = current_user
		@likes = @user.likes
	end

	# def favorite
	# 	@user = current_user
	# 	@favorite = Favorite.where( :user_id => @user.id )
	# end

	def write_user
		params.require(:user).permit(:nickname , :avatar)
	end

end

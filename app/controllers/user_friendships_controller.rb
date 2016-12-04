class UserFriendshipsController < ApplicationController

	def friendship
		@friends = User.find(current_user).inverse_friendships.where(:user_id => User.find(current_user).friendships.pluck(:friend_id))
	end

	def friend_request
		@friend_request = User.find(current_user).inverse_friendships.where.not(:user_id => User.find(current_user).friendships.pluck(:friend_id))
	end

	def invite_friendship
		@user = User.find(params[:user_id])
		if current_user.friends.include?(@user)
			current_user.friends.delete(@user)
		else
			current_user.friendships.create(:friend_id => params[:user_id])
		end

		respond_to do |format|
			format.js
		end
	end

	def accept_friendship
		@user = User.find(params[:user_id])
		current_user.friendships.create(:friend_id => @user.id)
		redirect_to friend_request_user_friendships_path(current_user)
	end

	def refuse_friendship
		@user = User.find(params[:user_id])
		# Friendship.where("user_id = ? AND friend_id = ?" , current_user.id , @user.id).delete
		@user.friends.delete(current_user)
		redirect_to friend_request_user_friendships_path(current_user)
	end
end

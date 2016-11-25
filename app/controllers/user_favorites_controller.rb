class UserFavoritesController < ApplicationController
	def create 
		@topic = Topic.find(params[:topic_id])
		@user = current_user
		@favorite = @user.favorites.build(:topic_id => params[:topic_id] , :user_id => params[:user_id])
		if @favorite.save
			flash[:notice] = "oooo"
			redirect_to topic_path(@topic)
		else
			flash[:alert] = "xxxx"
			render topic_path(@topic)
		end
	end




	private

	def write_favorite
		params.require(:favorite).permit(:topic_id , :user_id)
	end

end

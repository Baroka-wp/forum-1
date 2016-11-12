class TopicsController < ApplicationController

	before_action :find_user

	def index
		@topics = Topic.page(params[:page]).per(15)
	end

	def show 
		@topic = Topic.find(params[:id])
	end

	def new
		@topic = @user.topics.build
	end

	def create
		@topic = @user.topics.build(wirte_topic)
		if @topic.save
			flash[:notice] = "新增成功"
			redirect_to topics_path
		else
			render "new"
		end
	end

	def edit
		@topic = Topic.find(params[:id])
	end

	def update
		@topic = Topic.find(params[:id])
		if @topic.update(wirte_topic)
			flash[:notice] = "更新成功"
			redirect_to topic_path(@topic)
		else
			render "edit"
		end
	end

	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy
		flash[:alert] = "刪除成功"
		redirect_to topics_path
	end



	private

	def find_user
		@user = current_user
	end

	def wirte_topic
		params.require(:topic).permit(:tital , :t_content , :t_time , :user_id )
	end


end

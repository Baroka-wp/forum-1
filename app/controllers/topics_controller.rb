class TopicsController < ApplicationController

	before_action :find_user

	def index

		case params[:order]
		when "Update"
			sort_by = "comments.created_at DESC"
		when "Reply"
			sort_by = "comments_count DESC"
		when "Views"
			sort_by = "views_count DESC"
		when "created_at"
		end
		
		@topics = Topic.includes(:comments , :user).order(sort_by).page(params[:page]).per(15)
		
		if params[:keyword] 
			@search_by = params[:keyword]
			@topics = Topic.includes(:comments , :user , :categories).where( "categories.id" => @search_by ).order(sort_by).page(params[:page]).per(15)
		end

	end

	def show 
		@topic = Topic.find(params[:id])
		views = 1 + @topic.views_count
		@topic.update(:views_count => views)
		@comment = @topic.comments
	end

	def new
		authenticate_user!
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

	def about
		@users = User.all
		@topics = Topic.all
		@comments = Comment.all
	end

	



	private

	def find_user
		@user = current_user
	end

	def wirte_topic
		params.require(:topic).permit(:title , :t_content , :user_id , :comments_count , :views_count , :category_ids => [] )
	end


end

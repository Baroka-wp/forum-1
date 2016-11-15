class TopicsController < ApplicationController

	before_action :find_user

	def index

		if !params[:keyword] 
			

			case params[:order]
			when "Update"
				sort_by = "comments.created_at"
			when "Reply"
				sort_by = "comments_count"
			when "created_at"
			end
			@topics = Topic.includes(:comments , :user).order(sort_by).reverse_order.page(params[:page]).per(15)
		else	

			case params[:keyword]
			when "RPG"
				@search_by = "RPG"
			when "Action" 
				@search_by = "Action"
			when "Racing"
				@search_by = "Racing"
			when "FPS"
				@search_by = "FPS"
			end

			case params[:order]
			when "Update"
				sort_by = "comments.created_at"
			when "Reply"
				sort_by = "comments_count"
			when "created_at"
			end

			@topics = Topic.includes(:comments , :user , :categories).where( "categories.name" => "#{@search_by}" ).order(sort_by).reverse_order.page(params[:page]).per(10)
		end
	end

	def show 
		@topic = Topic.find(params[:id])
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

	def profile
		@user = current_user
		@topics = @user.topics
		@comments = @user.comments
	end



	private

	def find_user
		@user = current_user
	end

	def wirte_topic
		params.require(:topic).permit(:title , :t_content , :user_id , :comments_count , :category_ids => [] )
	end


end

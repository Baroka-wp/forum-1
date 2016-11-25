class TopicsController < ApplicationController

	before_action :find_user
	
	def index

		@categories = Category.all

		case params[:order]
		when "Update"
			sort_by = "comments.created_at DESC"
		when "Reply"
			sort_by = "comments_count DESC"
		when "Views"
			sort_by = "views_count DESC"
		when "created_at"
		end
		
		@topics = Topic.includes(:comments , :user).where( :draft => false ).order(sort_by).page(params[:page]).per(15)
		
		if params[:keyword] 
			@search_by = params[:keyword]
			@topics = Topic.includes(:comments , :user , :categories).where( :draft => false ).where( "categories.id" => @search_by ).order(sort_by).page(params[:page]).per(15)
		end
		#@topics = Topic.where('id = 1').or(Topic.where(:user_id => "3")).page(params[:page]).per(15)
	end

	def show 
		@topic = Topic.find(params[:id])
		views = 1 + @topic.views_count
		@topic.update(:views_count => views)
		@comment = @topic.comments.where( :draft => false )
		@favorite_users = @topic.liked_users
		@favorite = @user.favorites.build
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

	def favorite
		@topic = Topic.find(params[:id])
		@favorite = current_user.favorites.find_by_topic_id(@topic)
		if current_user.favorited_topics.include?(@topic)
			@favorite.destroy
		else
			Favorite.create( :topic => @topic , :user => current_user)
		end

		respond_to do |format|
			format.js
		end
	end

	def like
		@topic = Topic.find(params[:id])
		if current_user.liked_topics.include?(@topic)
			current_user.liked_topics.delete(@topic)
		else
			Like.create!( :topic => @topic, :user => current_user )
		end

		respond_to do |format|
			format.html { redirect_to event_path(@event) }
			format.js
		end
	end

	
	private

	def find_user
		@user = current_user
	end

	def wirte_topic
		params.require(:topic).permit(:title , :t_content , :user_id , :comments_count , :views_count , :draft , :avatar , :category_ids => [] )
	end


end

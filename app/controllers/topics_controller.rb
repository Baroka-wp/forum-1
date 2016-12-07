class TopicsController < ApplicationController

	before_action :find_user
	before_action :find_topic , :except => [:index , :new , :create , :about ]
	
	def index

		#  @topic.draft_time > Time.zone.now
		@topics_draft = Topic.where(:draft => true)
		@topics_draft.each do |draft|
			if Time.now > draft.draft_time 
				draft.update(:draft => false)
			end
		end

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
			@keyword_by = params[:keyword]
			@topics = Topic.includes(:comments , :user , :categories).where( :draft => false ).where( "categories.id" => @keyword_by ).order(sort_by).page(params[:page]).per(15)
		end

		if params[:search]
			@search_by = params[:search]
			@topics = Topic.includes(:tags).where("tags.name" => @search_by).page(params[:page]).per(15)
		end
		#@topics = Topic.where('id = 1').or(Topic.where(:user_id => "3")).page(params[:page]).per(15)
	end

	def show 
		limit(@topic.limit_id)
		views = 1 + @topic.views_count
		@topic.update(:views_count => views)
		@images = Image.where(:topic_id => @topic.id)
		@comment = @topic.comments.build
		@comments = @topic.comments.where(:draft => false)
		@favorite_users = @topic.liked_users
		@favorite = @user.favorites.build
		@tag = Tag.new
		@tags = Tag.all
	end

	def new
		authenticate_user!
		@topic = @user.topics.build
	end

	def create
		@tag = params['topic']['t_content'].split(/#/)
		params['topic']['t_content'] = @tag.shift
		@topic = @user.topics.build(wirte_topic)
		if @topic.save
			if params['images']
				params['images'].each do |image|
					@topic.images.create(image: image)
				end
			end

			@tag.each do |s|
				@c_tag = Tag.create(:name => s.rstrip)
				@topic.tag_topicships.create(:tag_id => @c_tag.id)
			end
			flash[:notice] = "新增成功"
			redirect_to topics_path
		else
			render "new"
		end
	end

	def edit
		
	end

	def update
		if @topic.update(wirte_topic)
			flash[:notice] = "更新成功"
			redirect_to topic_path(@topic)
		else
			render "edit"
		end
	end

	def destroy
		@topic.destroy
		flash[:alert] = "刪除成功"
		redirect_to topics_path
	end

	def about
		@users_count = User.all.size
		@topics_count = Topic.all.size
		@comments_count = Comment.all.size
	end

	def favorite
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
		if current_user.liked_topics.include?(@topic)
			current_user.liked_topics.delete(@topic)
		else
			Like.create!( :topic => @topic, :user => current_user )
		end
		@topic.reload
		respond_to do |format|
			format.js
		end
	end

	def subscribe
		if current_user.subscribed_topics.include?(@topic)
			current_user.subscribed_topics.delete(@topic)
		else
			Subscribe.create!(:topic => @topic , :user => current_user)
		end

		respond_to do |format|
			format.js
		end
	end

	def create_tag
		@tag = Tag.new(params.require(:tag).permit(:name))
		if @tag.save
			flash[:noitce] = "OOO"
			redirect_to topic_path(@topic)
		else
			flash[:alert] = "XXX"
			render "show"
		end
	end

	
	private

	def find_user
		@user = current_user
	end

	def find_topic
		@topic = Topic.find(params[:id])
	end

	def wirte_topic
		params.require(:topic).permit(:title , :t_content , :user_id , :comments_count , :views_count , :draft , :draft_time , :limit_id , { :category_ids => [] } , { :tag_ids => [] } )
	end

	def limit(id)
		case id
			when 1
				if current_user != @topic.user
					flash[:alert] = "你沒有權限"
					redirect_to :back
				end
			when 2
				if current_user != @topic.user
					if !(current_user.friendships.find_by_friend_id(@topic.user.id) && current_user.inverse_friendships.find_by_user_id(@topic.user.id))
						flash[:alert] = "想看就加我好友！！！！！！！！！！！！！！！！！！！！！！！！"
						redirect_to :back
					end
				end
		end
	end

end

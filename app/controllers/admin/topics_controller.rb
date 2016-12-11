class Admin::TopicsController < ApplicationController
	before_action :authenticate_user! 
	before_action :authenticate_admin
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
		
		@topics = Topic.includes(:comments , :user).where( :draft => false ).order(sort_by).page(params[:page]).per(15)
		
		if params[:keyword] 
			@search_by = params[:keyword]
			@topics = Topic.includes(:comments , :user , :categories).where( :draft => false ).where( "categories.id" => @search_by ).order(sort_by).page(params[:page]).per(15)
		end

	end

	def destroy
		@topic = Topic.find(params[:id])
		@topic.destroy
		flash[:alert] = "刪除成功"
		redirect_to topics_path
	end

	
	protected

	def find_user
		@user = current_user
	end

	def wirte_topic
		params.require(:topic).permit(:title , :content , :user_id , :comments_count , :views_count , :draft , :category_ids => [] )
	end

	def authenticate_admin
		unless current_user.admin?
		flash[:alert] = "Not allow!"
		redirect_to topics_path
		end
	end

end

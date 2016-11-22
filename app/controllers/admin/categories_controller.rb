class Admin::CategoriesController < ApplicationController

	before_action :authenticate_user! 
	before_action :authenticate_admin 

	def index
		@cateogries = Category.all
	end

	def show
		@category = Category.find(params[:id])
	end

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(write_category)
		if @category.save
			flash[:notice] = "新增成功"
			redirect_to admin_categories_path
		else
			render "new"
		end
	end

	def edit
		@category = Category.find(params[:id])
	end

	def update
		@category = Category.find(params[:id])
		if @category.update(write_category)
			flash[:notice] = "更新成功"
			redirect_to admin_categories_path
		else
			render "edit"
		end
	end


	protected

	def write_category
		params.require(:category).permit(:name)
	end

	def authenticate_admin
		unless current_user.admin?
		flash[:alert] = "Not allow!"
		redirect_to topics_path
		end
	end

end

class CategoriesController < ApplicationController
	before_action :set_category, only: [:show, :update, :destroy, :add_goods]

	def index
		if params['categoryId'] == 'all'
			@categories = Category.all
		elsif params['categoryId'] == nil
			@categories = Category.where({ supcategory_id: nil })
		else
			@categories = Category.where( { supcategory_id: params['categoryId'] } )
		end
		render json: @categories
	end

  def show
		render json: @category
 	end

	def create
		@category = Category.new(category_params)
		
		if @category.save
			render json: @category, status: :created, location: @category
		else
			render json: @category.errors, status: :unprocessable_entity
		end
	end

	def update
		if @category.update(category_params)
			render json: @category
		else
			render json: @category.errors, status: :unprocessable_entity
		end
	end

	def add_goods
		@category.good_ids = (@category.good_ids + params[:goodIds])
		render json: @category.goods
	end

	def destroy
		@category.destroy
	end

	private
	  def set_category
			@category = Category.find(params[:id])
		end

		def category_params
			params.require(:category).permit(:name, :supcategory_id, :goodIds)
		end
end

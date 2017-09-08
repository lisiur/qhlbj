class GoodsController < ApplicationController
	before_action :set_good, only: [:show, :update, :destroy]

	def index
		if params['categoryId'] == 'all'
			if params[:pageNum] and params[:pageSize]
				@goods = Good.limit(params[:pageSize].to_i).offset(params[:pageSize].to_i * (params[:pageNum].to_i-1))
			else
				@goods = Good.all
			end
		elsif params['categoryId'] == nil
			if params[:pageNum] and params[:pageSize]
				@goods= Good.where({ category_id: nil }).limit(params[:pageSize].to_.to_ii).offset(params[:pageSize].to_i * (params[:pageNum].to_i-1))
			else
				@goods= Good.where({ category_id: nil })
			end
		else
			if params[:pageNum] and params[:pageSize]
				@goods= Good.where({ category_id: params['categoryId'] }).limit(params[:pageSize].to_i).offset(params[:pageSize].to_i * (params[:pageNum]-1))
			else
				@goods= Good.where({ category_id: params['categoryId'] })
			end
		end
		render json: @goods.order('created_at DESC')
	end

	def show
		if @good.category
			render json: { good: @good, category: @good.category, supcategory: @good.category.supcategory}
		else
			render json: { good: @good, category: nil, supcategory: nil}
		end
 	end

	def create
		@good = Good.new(good_params)
		
		if @good.save
			render json: @good, status: :created, location: @good
		else
			render json: @good.errors, status: :unprocessable_entity
		end
	end

	def update
		if @good.update(good_params)
			render json: @good
		else
			render json: @good.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@good.destroy
	end

	private
	  def set_good
			@good = Good.find(params[:id])
		end

		def good_params
			params.require(:good).permit(:name, :description, :category_id, :avatar, :pageSize, :pageNum)
		end
end

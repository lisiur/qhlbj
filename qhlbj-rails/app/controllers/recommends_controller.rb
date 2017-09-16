class RecommendsController < ApplicationController
  before_action :set_recommend, only: [:show, :update, :destroy]

  # GET /recommends
  def index
    @recommends = Recommend.all

    render json: @recommends
  end

  # GET /recommends/1
  def show
    render json: @recommend
  end

  # POST /recommends
  def create
    @recommend = Recommend.new(recommend_params)

    if @recommend.save
      render json: @recommend, status: :created, location: @recommend
    else
      render json: @recommend.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /recommends/1
  def update
    if @recommend.update(recommend_params)
      render json: @recommend
    else
      render json: @recommend.errors, status: :unprocessable_entity
    end
  end

  # DELETE /recommends/1
  def destroy
    @recommend.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recommend
      @recommend = Recommend.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def recommend_params
      params.fetch(:recommend, {})
    end
end

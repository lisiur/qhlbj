class CarouselsController < ApplicationController
  before_action :set_carousel, only: [:index, :update_goods]

  # GET /carousels
  def index
    render json: @carousel.goods
  end

  # GET /carousels/1
  def show
    render json: @carousel
  end

  # POST /carousels
  def create
    @carousel = Carousel.new(carousel_params)

    if @carousel.save
      render json: @carousel, status: :created, location: @carousel
    else
      render json: @carousel.errors, status: :unprocessable_entity
    end
  end

	def update_goods
		@carousel.good_ids = params[:goodIds]
		render json: @carousel.goods
	end

  # PATCH/PUT /carousels/1
  def update
    if @carousel.update(carousel_params)
      render json: @carousel
    else
      render json: @carousel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /carousels/1
  def destroy
    @carousel.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_carousel
      @carousel = Carousel.first
    end

    # Only allow a trusted parameter "white list" through.
    def carousel_params
			params.require(:carousel).permit(:goodIds)
    end
end

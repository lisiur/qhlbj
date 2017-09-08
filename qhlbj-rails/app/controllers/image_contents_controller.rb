class ImageContentsController < ApplicationController
  def create
    @image = Image.new(name: params[:file])
    if @image.save!
      render json: @image
    end
  end
end

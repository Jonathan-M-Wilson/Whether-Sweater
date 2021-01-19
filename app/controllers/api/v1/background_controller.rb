class Api::V1::BackgroundController < ApplicationController
  def index
    if params[:location].blank?
      render json: { 'errors': 'No location specified' }, status: :bad_request
    else
      render json: ImageSerializer.new(image)
    end
  end

  private

  def image
    ImageFacade.get_background(params[:location])
  end
end

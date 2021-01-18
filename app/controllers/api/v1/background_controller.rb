class Api::V1::BackgroundController < ApplicationController
    def index
      if params[:location].nil? || params[:location].empty?
        render json: { 'errors': 'No location specified' }, status: 400
      else
        render json: ImageSerializer.new(image)
      end
    end

  private

  def image
    ImageFacade.get_background(params[:location])
  end
end
